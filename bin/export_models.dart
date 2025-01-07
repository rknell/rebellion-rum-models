/// Export Models Utility
///
/// A command-line tool that connects to a MongoDB database and exports sample data
/// for model generation. This utility is a crucial part of the model generation
/// workflow, ensuring that models accurately reflect the current database schema.
///
/// Usage:
/// ```bash
/// dart run bin/export_models.dart --connection-string='mongodb://your-connection-string'
/// ```
/// Note: Use single quotes around the connection string if it contains special characters.
///
/// Features:
/// - Connects to any MongoDB database using a connection string
/// - Exports the latest 50 documents from each collection
/// - Creates JSON files named after each collection
/// - Stores exports in lib/src/sample_data/ directory
/// - Maintains data structure for model generation
///
/// The exported data serves multiple purposes:
/// 1. Source of truth for model generation
/// 2. Test data for serialization/deserialization
/// 3. Documentation of actual data structures
/// 4. Reference for field types and nullability
///
/// Example connection strings:
/// - Local: mongodb://localhost:27017/database_name
/// - Atlas: mongodb+srv://username:password@cluster.mongodb.net/database_name
/// - Replica Set: mongodb://host1:27017,host2:27017/database_name?replicaSet=rs0
///
/// Security Note:
/// - Ensure your connection string is kept secure
/// - Do not commit connection strings to version control
/// - Consider using environment variables for sensitive data

import 'dart:io';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:args/args.dart';
import 'package:fixnum/fixnum.dart' show Int64;

/// Converts MongoDB document to JSON-serializable format
Map<String, dynamic> _convertMongoDocument(Map<String, dynamic> document) {
  return document.map((key, value) {
    if (value is Int64) {
      return MapEntry(key, value.toString());
    } else if (value is ObjectId) {
      return MapEntry(key, value.toHexString());
    } else if (value is Map) {
      return MapEntry(
          key, _convertMongoDocument(value as Map<String, dynamic>));
    } else if (value is List) {
      return MapEntry(
          key,
          value.map((item) {
            if (item is Map) {
              return _convertMongoDocument(item as Map<String, dynamic>);
            }
            return item;
          }).toList());
    }
    return MapEntry(key, value);
  });
}

/// Main entry point for the export utility.
///
/// Accepts command line arguments and manages the export process.
/// Will exit with code 1 if any errors occur during execution.
Future<void> main(List<String> arguments) async {
  final parser = ArgParser()
    ..addOption('connection-string',
        abbr: 'c', help: 'MongoDB connection string', mandatory: true);

  final results = parser.parse(arguments);
  final connectionString = results['connection-string'] as String;

  try {
    final db = await Db.create(connectionString);
    await db.open();

    print('Connected to database successfully');

    // Create output directory if it doesn't exist
    final outputDir = Directory('lib/src/sample_data');
    if (!await outputDir.exists()) {
      await outputDir.create(recursive: true);
    }

    // Get all collection names
    final collections = await db.getCollectionNames();
    print('Found collections: ${collections.join(', ')}');

    for (final collectionName in collections) {
      if (collectionName == null) continue;
      print('Processing collection: $collectionName');

      final collection = db.collection(collectionName);
      final cursor = collection.find();
      final documents = await cursor.take(50).toList();

      // Convert documents to JSON-serializable format
      final jsonDocuments =
          documents.map((doc) => _convertMongoDocument(doc)).toList();

      final outputFile = File('${outputDir.path}/$collectionName.json');
      await outputFile.writeAsString(
        JsonEncoder.withIndent('  ').convert(jsonDocuments),
      );

      print('Exported ${documents.length} documents from $collectionName');
    }

    await db.close();
    print('Database export completed successfully');
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}
