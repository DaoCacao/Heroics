import 'package:logger/logger.dart';

class Log {
  final Logger logger;

  const Log({required this.logger});

  void v(dynamic message, [dynamic error]) => logger.v(message, error);

  void d(dynamic message, [dynamic error]) => logger.d(message, error);

  void i(dynamic message, [dynamic error]) => logger.i(message, error);

  void w(dynamic message, [dynamic error]) => logger.w(message, error);

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      logger.e(message, error, stackTrace);
}
