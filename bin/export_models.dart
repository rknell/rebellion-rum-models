import 'dart:io';
import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:args/args.dart';

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

      final outputFile = File('${outputDir.path}/$collectionName.json');
      await outputFile.writeAsString(
        JsonEncoder.withIndent('  ').convert(documents),
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
