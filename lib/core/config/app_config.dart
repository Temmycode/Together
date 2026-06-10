import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';

/// Build flavors. The running flavor is selected by the entrypoint
/// (`main_dev.dart` / `main_staging.dart` / `main_prod.dart`).
enum Flavor { dev, staging, prod }

/// Immutable, per-flavor application configuration.
///
/// This is plain configuration (not loaded from JSON) resolved once at startup
/// and injected via `appConfigProvider`. Read it anywhere with
/// `ref.watch(appConfigProvider)`.
@freezed
abstract class AppConfig with _$AppConfig {
  const AppConfig._();

  const factory AppConfig({
    required Flavor flavor,
    required String appName,
    required String baseUrl,
    required Duration connectTimeout,
    required Duration receiveTimeout,
    required bool enableVerboseLogging,
  }) = _AppConfig;

  /// Local/dev environment. Points at a public API so the sample feature works
  /// out of the box.
  factory AppConfig.dev() => const AppConfig(
        flavor: Flavor.dev,
        appName: 'Together (dev)',
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),
        enableVerboseLogging: true,
      );

  factory AppConfig.staging() => const AppConfig(
        flavor: Flavor.staging,
        appName: 'Together (staging)',
        baseUrl: 'https://staging.example.com',
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),
        enableVerboseLogging: true,
      );

  factory AppConfig.prod() => const AppConfig(
        flavor: Flavor.prod,
        appName: 'Together',
        baseUrl: 'https://api.example.com',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        enableVerboseLogging: false,
      );

  bool get isProd => flavor == Flavor.prod;
}
