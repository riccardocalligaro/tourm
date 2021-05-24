import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tourm_app/core/infrastructure/error/types/failures.dart';

Failure handleError(
  dynamic e, [
  StackTrace s,
]) {
  // log the errror
  print(e);

  if (e is Exception) {
  } else {
    e = Exception(e.toString());
  }

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
