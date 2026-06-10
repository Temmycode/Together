import 'package:dio/dio.dart';
import 'package:together/core/storage/key_value_store.dart';

/// Attaches the bearer token (when present) to outgoing requests.
///
/// Scaffolded for a future auth feature: it reads the token from the
/// [KeyValueStore] under [tokenKey]. Until something writes that key it is a
/// no-op, so it's safe to keep installed.
class AuthInterceptor extends Interceptor {
  const AuthInterceptor(this._store);

  final KeyValueStore _store;

  static const String tokenKey = 'auth_token';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _store.getString(tokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
