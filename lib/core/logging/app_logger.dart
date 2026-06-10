import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/config/app_config_provider.dart';

part 'app_logger.g.dart';

/// Severity levels, ordered low → high.
enum LogLevel { debug, info, warning, error }

/// A tiny structured logger that wraps `dart:developer`'s `log()`.
///
/// Custom on purpose (no logging package): debug/info are dropped in release
/// builds or when [verbose] is false; warnings/errors always log. Inject via
/// `appLoggerProvider`, or construct directly for use before the
/// `ProviderScope` exists (e.g. in `bootstrap()`).
class AppLogger {
  const AppLogger({this.verbose = true});

  /// When `false`, [debug]/[info] are suppressed.
  final bool verbose;

  void debug(String message, {String? name}) =>
      _log(LogLevel.debug, message, name: name);

  void info(String message, {String? name}) =>
      _log(LogLevel.info, message, name: name);

  void warning(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? name,
  }) => _log(
    LogLevel.warning,
    message,
    error: error,
    stackTrace: stackTrace,
    name: name,
  );

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? name,
  }) => _log(
    LogLevel.error,
    message,
    error: error,
    stackTrace: stackTrace,
    name: name,
  );

  void _log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? name,
  }) {
    final isLowSeverity = level == LogLevel.debug || level == LogLevel.info;
    if (isLowSeverity && (kReleaseMode || !verbose)) return;

    developer.log(
      message,
      name: name == null ? 'together' : 'together.$name',
      level: _levelValue(level),
      error: error,
      stackTrace: stackTrace,
    );
  }

  int _levelValue(LogLevel level) => switch (level) {
    LogLevel.debug => 500,
    LogLevel.info => 800,
    LogLevel.warning => 900,
    LogLevel.error => 1000,
  };
}

/// App-wide logger, with verbosity taken from the active flavor.
@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) =>
    AppLogger(verbose: ref.watch(appConfigProvider).enableVerboseLogging);
