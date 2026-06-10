import 'package:together/app/bootstrap.dart';
import 'package:together/core/config/app_config.dart';

/// Dev flavor entrypoint: `flutter run -t lib/main_dev.dart`.
Future<void> main() => bootstrap(AppConfig.dev());
