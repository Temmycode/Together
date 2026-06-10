import 'package:flutter/widgets.dart';
import 'package:together/core/responsive/device_type.dart';
import 'package:together/core/responsive/size_config.dart';

/// Ergonomic responsive helpers on [BuildContext].
///
/// The pixel math (`w`/`h`/`sp`, `screenWidth`, …) reads `MediaQuery.sizeOf`, so
/// a widget that uses only these rebuilds on resize but *not* on unrelated
/// MediaQuery changes. Use [sizeConfig] when you need the full snapshot (fold
/// posture, text scaler) for layout decisions or `ResponsiveLayout`.
extension SizeConfigX on BuildContext {
  /// The full geometry snapshot (reads the whole [MediaQuery]).
  SizeConfig get sizeConfig => SizeConfig.of(this);

  Size get _size => MediaQuery.sizeOf(this);

  double get screenWidth => _size.width;
  double get screenHeight => _size.height;

  /// Safe-area insets (status bar, notch, navigation bar).
  EdgeInsets get safePadding => MediaQuery.paddingOf(this);

  /// Insets covered by system UI, e.g. the on-screen keyboard.
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  DeviceType get deviceType => SizeConfig.deviceTypeOf(_size);
  bool get isPhone => deviceType == DeviceType.phone;
  bool get isTablet => deviceType != DeviceType.phone;

  /// Proportional width for a design-baseline value.
  double w(double designPx) => SizeConfig.scaleWidth(designPx, _size);

  /// Proportional height for a design-baseline value.
  double h(double designPx) => SizeConfig.scaleHeight(designPx, _size);

  /// Gentle responsive font size for a design-baseline value.
  double sp(double designPx) => SizeConfig.scaleText(designPx, _size);
}
