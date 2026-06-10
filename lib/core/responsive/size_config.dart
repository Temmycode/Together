import 'dart:math' as math;
import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/widgets.dart';
import 'package:together/core/responsive/device_type.dart';

/// Immutable snapshot of the current screen geometry, recomputed each build
/// from [MediaQuery].
///
/// Unlike the common `SizeConfig.init(context)` singleton found in many
/// tutorials, nothing is cached in global mutable state — so values are always
/// correct after a rotation, window resize, split-screen change, or fold /
/// unfold. Build it with [SizeConfig.of], or use the cheaper `BuildContext`
/// extensions in `context_extensions.dart` for pure pixel math.
@immutable
class SizeConfig {
  const SizeConfig({
    required this.size,
    required this.deviceType,
    required this.orientation,
    required this.foldPosture,
    required this.hingeBounds,
    required this.textScaler,
  });

  /// Design baseline the proportions are relative to (iPhone 13/14 logical px).
  static const double baseWidth = 390;
  static const double baseHeight = 844;

  /// `shortestSide` breakpoints used to classify the device.
  static const double phoneBreakpoint = 600;
  static const double tabletBreakpoint = 900;

  /// Bounds applied to text scaling so large accessibility settings (or big
  /// tablets) never blow the layout apart.
  static const double minTextScale = 0.85;
  static const double maxTextScale = 1.3;

  final Size size;
  final DeviceType deviceType;
  final Orientation orientation;
  final FoldPosture foldPosture;

  /// Bounds of the fold/hinge in local coordinates, or `null` when there is
  /// none (always `null` on iOS).
  final Rect? hingeBounds;

  /// User text scaling, already clamped to [minTextScale]..[maxTextScale].
  final TextScaler textScaler;

  /// Build from the full [MediaQuery] (needed for fold + text-scale data).
  factory SizeConfig.of(BuildContext context) {
    final mq = MediaQuery.of(context);
    final hinge = _findHinge(mq.displayFeatures);
    return SizeConfig(
      size: mq.size,
      deviceType: deviceTypeOf(mq.size),
      orientation: mq.orientation,
      foldPosture: _postureOf(hinge),
      hingeBounds: hinge?.bounds,
      textScaler: mq.textScaler
          .clamp(minScaleFactor: minTextScale, maxScaleFactor: maxTextScale),
    );
  }

  // --- Static math, shared with the cheap BuildContext extensions ---

  static DeviceType deviceTypeOf(Size size) {
    final shortest = math.min(size.width, size.height);
    if (shortest < phoneBreakpoint) return DeviceType.phone;
    if (shortest < tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.largeTablet;
  }

  /// Width proportional to the design baseline. Linear on phones, but damped
  /// past phone size so a 200px card doesn't balloon to 500px on an iPad.
  static double scaleWidth(double designPx, Size size) {
    final linear = designPx / baseWidth * size.width;
    return deviceTypeOf(size) == DeviceType.phone
        ? linear
        : designPx + (linear - designPx) * 0.5;
  }

  /// Height proportional to the design baseline.
  static double scaleHeight(double designPx, Size size) =>
      designPx / baseHeight * size.height;

  /// A gentle font size for [designPx]: scales with phone width, with a small
  /// fixed bump on tablets, clamped both ways. Complements the global
  /// text-scale clamp applied in `app.dart`.
  static double scaleText(double designPx, Size size) {
    final factor =
        deviceTypeOf(size) == DeviceType.phone ? size.width / baseWidth : 1.1;
    return designPx * factor.clamp(minTextScale, maxTextScale);
  }

  static DisplayFeature? _findHinge(List<DisplayFeature> features) {
    for (final feature in features) {
      if (feature.type == DisplayFeatureType.fold ||
          feature.type == DisplayFeatureType.hinge) {
        return feature;
      }
    }
    return null;
  }

  static FoldPosture _postureOf(DisplayFeature? hinge) => switch (hinge?.state) {
        DisplayFeatureState.postureFlat => FoldPosture.flat,
        DisplayFeatureState.postureHalfOpened => FoldPosture.halfOpened,
        _ => FoldPosture.none,
      };

  // --- Instance conveniences ---

  double get screenWidth => size.width;
  double get screenHeight => size.height;

  double w(double designPx) => scaleWidth(designPx, size);
  double h(double designPx) => scaleHeight(designPx, size);
  double sp(double designPx) => scaleText(designPx, size);

  bool get isPhone => deviceType == DeviceType.phone;
  bool get isTablet => deviceType != DeviceType.phone;
  bool get isLargeTablet => deviceType == DeviceType.largeTablet;
  bool get isLandscape => orientation == Orientation.landscape;

  /// Whether the window currently spans a fold/hinge (Android foldables).
  bool get hasFold => foldPosture != FoldPosture.none;

  /// A vertical fold/hinge — taller than it is wide — suitable for splitting
  /// content into left/right panes around the crease.
  bool get hasVerticalFold {
    final hinge = hingeBounds;
    return hinge != null && hinge.height >= hinge.width;
  }

  /// Pick a value by device type, falling back to smaller breakpoints.
  T responsive<T>({required T phone, T? tablet, T? largeTablet}) =>
      switch (deviceType) {
        DeviceType.largeTablet => largeTablet ?? tablet ?? phone,
        DeviceType.tablet => tablet ?? phone,
        DeviceType.phone => phone,
      };
}
