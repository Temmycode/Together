import 'package:together/app/bootstrap.dart';
import 'package:together/core/config/app_config.dart';

/// Default entrypoint (dev flavor) so `flutter run` works with no `-t` flag.
///
/// For an explicit flavor, run a dedicated entrypoint instead, e.g.
/// `flutter run -t lib/main_staging.dart`.
Future<void> main() => bootstrap(AppConfig.dev());
