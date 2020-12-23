import 'package:logger/logger.dart';

import 'package:domain/gateways/error_logger.dart';

class ErrorLogger implements ErrorLoggerGateway {
  final Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  void logError(dynamic error) {
    final stackTrace = error is Error ? error.stackTrace : null;
    logger.e('UseCase Error', [error, stackTrace]);
  }
}
