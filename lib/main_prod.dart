import 'package:together/app/bootstrap.dart';
import 'package:together/core/config/app_config.dart';

/// Production flavor entrypoint: `flutter run -t lib/main_prod.dart`.
Future<void> main() => bootstrap(AppConfig.prod());
