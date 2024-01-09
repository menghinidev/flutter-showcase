import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final loggerManagerProvider = Provider<LoggerManager>((ref) {
  final logger = Logger();
  return LoggerManager(logger: logger);
});

extension LoggerProvider on WidgetRef {
  void logMessage(String message) => read(loggerManagerProvider).logMessage(message);
}

class LoggerManager {
  LoggerManager({required this.logger});

  final Logger logger;

  void logMessage(String message) => logger.i(message);
}
