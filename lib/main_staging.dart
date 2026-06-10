import 'package:together/app/bootstrap.dart';
import 'package:together/core/config/app_config.dart';

/// Staging flavor entrypoint: `flutter run -t lib/main_staging.dart`.
Future<void> main() => bootstrap(AppConfig.staging());
