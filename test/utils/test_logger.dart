import 'package:logging/logging.dart';

/// A standardized logging utility for test files across the Rebellion Rum codebase.
///
/// This utility provides structured logging capabilities to replace direct use of
/// print statements in test files. It uses the `logging` package internally to
/// provide different log levels and consistent formatting.
///
/// Usage:
/// ```dart
/// import 'package:rebellion_rum_models/test/utils/test_logger.dart';
///
/// void main() {
///   test('example test', () {
///     TestLogger.debug('Detailed debug information');
///     TestLogger.info('General test information');
///     TestLogger.warning('Warning about potential issues');
///     TestLogger.error('Error information');
///   });
/// }
/// ```
///
/// See the test-logging.mdc file in .cursor/rules for complete documentation
/// and best practices.
class TestLogger {
  /// The internal logger instance
  static final _logger = Logger('TestLogger');

  /// Initializes the logger with default configuration
  static void _initializeIfNeeded() {
    if (Logger.root.level == Level.OFF) {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        // Format: [LEVEL] message
        _logger.info('[${record.level.name}] ${record.message}');
      });
    }
  }

  /// Logs a message at INFO level
  ///
  /// Use this for general information about test execution, successful operations,
  /// and important test milestones.
  ///
  /// Example:
  /// ```dart
  /// TestLogger.info('Test setup completed successfully');
  /// ```
  static void info(String message) {
    _initializeIfNeeded();
    _logger.info(message);
  }

  /// Logs a message at WARNING level
  ///
  /// Use this for potentially harmful situations that don't prevent the test
  /// from continuing but should be noted.
  ///
  /// Example:
  /// ```dart
  /// TestLogger.warning('Deprecated API method used in test');
  /// ```
  static void warning(String message) {
    _initializeIfNeeded();
    _logger.warning(message);
  }

  /// Logs a message at SEVERE level
  ///
  /// Use this for error events that might still allow the test to continue running
  /// but indicate significant problems.
  ///
  /// Example:
  /// ```dart
  /// TestLogger.error('Failed to connect to mock service');
  /// ```
  static void error(String message) {
    _initializeIfNeeded();
    _logger.severe(message);
  }

  /// Logs a message at FINE level (debug)
  ///
  /// Use this for detailed information that is primarily useful for
  /// diagnosing problems.
  ///
  /// Example:
  /// ```dart
  /// TestLogger.debug('Request payload: $payload');
  /// ```
  static void debug(String message) {
    _initializeIfNeeded();
    _logger.fine(message);
  }
}
