/// Typography configuration.
///
/// [fontFamily] is applied app-wide by `AppTheme`. Point it at a family
/// registered under `flutter: fonts:` in `pubspec.yaml` when a custom font is
/// added; `null` keeps the platform default. Per-role sizes come from the
/// Material 3 [TextTheme]; use `context.sp(...)` for explicit responsive sizing.
abstract final class AppTypography {
  const AppTypography._();

  static const String? fontFamily = null;
}
