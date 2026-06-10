import 'package:dio/dio.dart';
import 'package:together/core/logging/app_logger.dart';

/// Logs each request/response/error through the app [AppLogger].
///
/// Request/response bodies are only logged when [verbose] is true (dev/staging)
/// to avoid leaking payloads in release builds.
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor(this._logger, {this.verbose = false});

  final AppLogger _logger;
  final bool verbose;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.debug('→ ${options.method} ${options.uri}', name: 'http');
    if (verbose && options.data != null) {
      _logger.debug('  body: ${options.data}', name: 'http');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.debug(
      '← ${response.statusCode} ${response.requestOptions.uri}',
      name: 'http',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.warning(
      '✗ ${err.response?.statusCode ?? ''} ${err.requestOptions.uri} — ${err.message}',
      name: 'http',
      error: err,
    );
    handler.next(err);
  }
}
