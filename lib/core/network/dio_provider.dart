import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/config/app_config_provider.dart';
import 'package:together/core/logging/app_logger.dart';
import 'package:together/core/network/interceptors/auth_interceptor.dart';
import 'package:together/core/network/interceptors/logging_interceptor.dart';
import 'package:together/core/storage/storage_provider.dart';

part 'dio_provider.g.dart';

/// The app's single, configured [Dio] client.
///
/// Built from the active [appConfigProvider] (base URL + timeouts) and kept
/// alive for the app's lifetime. Feature data sources depend on this directly
/// — there is no extra wrapper layer over Dio.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final config = ref.watch(appConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  final store = ref.watch(keyValueStoreProvider);

  final client = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
      headers: const {'Content-Type': 'application/json'},
    ),
  );

  client.interceptors.addAll([
    AuthInterceptor(store),
    LoggingInterceptor(logger, verbose: config.enableVerboseLogging),
  ]);

  ref.onDispose(client.close);
  return client;
}
