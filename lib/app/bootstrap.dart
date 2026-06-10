import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:together/app/app.dart';
import 'package:together/core/config/app_config.dart';
import 'package:together/core/config/app_config_provider.dart';
import 'package:together/core/logging/app_logger.dart';
import 'package:together/core/storage/storage_provider.dart';

/// Shared startup path for every flavor entrypoint.
///
/// This is the *single* place async initialization happens: resolve
/// [SharedPreferences] once, then inject it (and the chosen flavor [config])
/// into the provider graph via overrides so the rest of the app reads them
/// synchronously — no provider downstream has to be async just to read prefs.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  final logger = AppLogger(verbose: config.enableVerboseLogging);
  FlutterError.onError = (details) {
    logger.error(
      'Uncaught framework error',
      error: details.exception,
      stackTrace: details.stack,
      name: 'flutter',
    );
    FlutterError.presentError(details);
  };

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      // Disable Riverpod 3's implicit auto-retry-on-error: this app surfaces
      // failures explicitly (AppErrorView + a manual retry button) for a
      // predictable error UX. Remove this, or return a backoff Duration, to
      // opt back into automatic retries.
      retry: (_, _) => null,
      overrides: [
        appConfigProvider.overrideWithValue(config),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const TogetherApp(),
    ),
  );
}
