import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/config/app_config.dart';

part 'app_config_provider.g.dart';

/// The active [AppConfig].
///
/// Overridden in `bootstrap()` with the flavor chosen by the entrypoint;
/// reading it without that override is a programming error, so it fails loud.
@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) => throw UnimplementedError(
      'appConfigProvider must be overridden in bootstrap().',
    );
