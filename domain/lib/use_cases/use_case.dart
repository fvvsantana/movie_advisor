import 'package:meta/meta.dart';

import 'package:domain/errors.dart';
import 'package:domain/error_logger.dart';

abstract class UseCase<P, R> {
  const UseCase({@required this.logger}) : assert(logger != null);

  final ErrorLoggerGateway logger;

  @protected
  Future<R> getRawFuture({P params});

  Future<R> getFuture({P params}) => getRawFuture(params: params).catchError(
        (error) {
          logger.logError(error);
          throw error;
        },
      ).catchError(
        (error) {
          if (error is! CustomError) {
            throw const UnexpectedError();
          } else {
            throw error;
          }
        },
      );
}
