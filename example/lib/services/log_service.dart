import 'package:app/utils/build_config.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class LogService {
  final _logger = Logger(
    level: BuildConfig.loggerLevel.getServiceLevel(),
    printer: SimplePrinter(colors: false),
  );

  /// Log a message at level [Level.trace].
  void t(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) =>
      _logger.t(message, time: time, error: error, stackTrace: stackTrace);

  /// Log a message at level [Level.debug].
  void d(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) =>
      _logger.d(message, time: time, error: error, stackTrace: stackTrace);

  /// Log a message at level [Level.info].
  void i(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) =>
      _logger.i(message, time: time, error: error, stackTrace: stackTrace);

  /// Log a message at level [Level.warning].
  void w(dynamic message, Object? error, StackTrace? stackTrace, {DateTime? time}) =>
      _logger.w(message, time: time, error: error, stackTrace: stackTrace);

  /// Log a message at level [Level.error].
  void e(dynamic message, Object? error, StackTrace? stackTrace, {DateTime? time}) =>
      _logger.e(message, time: time, error: error, stackTrace: stackTrace);

  /// Log a message at level [Level.fatal].
  void f(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) =>
      _logger.f(message, time: time, error: error, stackTrace: stackTrace);
}
