import 'package:dio/dio.dart';
import 'package:together/core/error/result.dart';

/// Maps a thrown [error] into a typed [Failure].
///
/// This is the single seam where exceptions cross into the domain: repositories
/// call it in their `catch` blocks so the rest of the app only ever deals with
/// [Failure]s, never raw transport exceptions.
Failure mapErrorToFailure(Object error) {
  if (error is Failure) return error;
  if (error is DioException) return _mapDioException(error);
  return const UnknownFailure();
}

Failure _mapDioException(DioException e) {
  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout =>
      const NetworkFailure('The connection timed out. Please try again.'),
    DioExceptionType.connectionError =>
      const NetworkFailure(),
    DioExceptionType.badCertificate =>
      const NetworkFailure('Could not establish a secure connection.'),
    DioExceptionType.cancel =>
      const NetworkFailure('The request was cancelled.'),
    DioExceptionType.badResponse =>
      _mapStatusCode(e.response?.statusCode),
    DioExceptionType.unknown =>
      const UnknownFailure(),
  };
}

Failure _mapStatusCode(int? statusCode) {
  if (statusCode == null) return const ServerFailure();
  return switch (statusCode) {
    401 || 403 => const UnauthorizedFailure(),
    >= 500 => ServerFailure('Server error ($statusCode). Please try again later.', statusCode),
    _ => ServerFailure('Request failed ($statusCode).', statusCode),
  };
}
