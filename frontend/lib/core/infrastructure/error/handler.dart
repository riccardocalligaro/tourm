import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:tourm_app/core/infrastructure/error/types/failures.dart';
import 'package:tourm_app/core/infrastructure/log/logger.dart';

Failure handleError(
  Exception e, [
  StackTrace s,
]) {
  // log the errror
  Logger.error(e, s);

  if (e is DioError) {
    if (e is TimeoutException || e is SocketException || e.response == null) {
      return NetworkFailure(dioError: e);
    } else if (e.response.statusCode >= 500) {
      return ServerFailure(e);
    } else {
      return NetworkFailure(dioError: e);
    }
  } else {
    // if (e is SqliteException || e is MoorWrappedException) {
    //   return DatabaseFailure();
    // }
    return GenericFailure(e: e);
  }
}
