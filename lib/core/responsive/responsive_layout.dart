import 'package:flutter/material.dart';
import 'package:together/core/responsive/device_type.dart';
import 'package:together/core/responsive/size_config.dart';

/// Chooses a builder by [DeviceType], falling back to the next-smaller builder
/// when a larger one is omitted — so you only write the layouts that differ.
///
/// ```dart
/// ResponsiveLayout(
///   phone: (_) => const _SingleColumn(),
///   tablet: (_) => const _TwoPane(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.phone,
    this.tablet,
    this.largeTablet,
  });

  final WidgetBuilder phone;
  final WidgetBuilder? tablet;
  final WidgetBuilder? largeTablet;

  @override
  Widget build(BuildContext context) {
    final type = SizeConfig.deviceTypeOf(MediaQuery.sizeOf(context));
    return switch (type) {
      DeviceType.largeTablet => (largeTablet ?? tablet ?? phone)(context),
      DeviceType.tablet => (tablet ?? phone)(context),
      DeviceType.phone => phone(context),
    };
  }
}

/// A side-by-side two-pane layout that is foldable-aware: when the window spans
/// a vertical fold/hinge, the panes are placed on either side of the crease so
/// no content is hidden beneath it. Otherwise it falls back to a flex split
/// with a divider.
class TwoPane extends StatelessWidget {
  const TwoPane({
    super.key,
    required this.start,
    required this.end,
    this.startFlex = 2,
    this.endFlex = 3,
  });

  final Widget start;
  final Widget end;
  final int startFlex;
  final int endFlex;

  @override
  Widget build(BuildContext context) {
    final sc = SizeConfig.of(context);
    final hinge = sc.hingeBounds;

    if (sc.hasVerticalFold && hinge != null) {
      return Row(
        children: [
          SizedBox(width: hinge.left, child: start),
          SizedBox(width: hinge.width), // empty gap over the crease
          Expanded(child: end),
        ],
      );
    }

    return Row(
      children: [
        Expanded(flex: startFlex, child: start),
        const VerticalDivider(width: 1),
        Expanded(flex: endFlex, child: end),
      ],
    );
  }
}
