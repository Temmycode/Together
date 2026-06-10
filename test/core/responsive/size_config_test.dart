import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/responsive/device_type.dart';
import 'package:together/core/responsive/size_config.dart';

void main() {
  group('SizeConfig.deviceTypeOf', () {
    test('classifies by shortest side (rotation-invariant)', () {
      expect(SizeConfig.deviceTypeOf(const Size(390, 844)), DeviceType.phone);
      expect(SizeConfig.deviceTypeOf(const Size(844, 390)), DeviceType.phone);
      expect(SizeConfig.deviceTypeOf(const Size(768, 1024)), DeviceType.tablet);
      expect(
        SizeConfig.deviceTypeOf(const Size(1024, 1366)),
        DeviceType.largeTablet,
      );
    });
  });

  group('SizeConfig scaling', () {
    const baseline = Size(SizeConfig.baseWidth, SizeConfig.baseHeight);
    const tablet = Size(768, 1024);

    test('width/height scale ~1:1 at the design baseline', () {
      expect(SizeConfig.scaleWidth(100, baseline), closeTo(100, 0.001));
      expect(SizeConfig.scaleHeight(100, baseline), closeTo(100, 0.001));
    });

    test('width scaling is damped on tablets (sub-linear, but > baseline)', () {
      final linear = 100 / SizeConfig.baseWidth * tablet.width;
      final scaled = SizeConfig.scaleWidth(100, tablet);
      expect(scaled, greaterThan(100));
      expect(scaled, lessThan(linear));
    });

    test('text scaling is clamped both ways', () {
      // Very narrow → would scale below min, clamped up.
      expect(
        SizeConfig.scaleText(10, const Size(200, 800)),
        closeTo(10 * SizeConfig.minTextScale, 0.001),
      );
      // Very wide phone → would scale above max, clamped down.
      expect(
        SizeConfig.scaleText(10, const Size(560, 590)),
        closeTo(10 * SizeConfig.maxTextScale, 0.001),
      );
    });
  });

  testWidgets('SizeConfig.of reads MediaQuery and classifies the device',
      (tester) async {
    late SizeConfig captured;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(768, 1024)),
        child: Builder(
          builder: (context) {
            captured = SizeConfig.of(context);
            return const SizedBox();
          },
        ),
      ),
    );

    expect(captured.deviceType, DeviceType.tablet);
    expect(captured.isTablet, isTrue);
    expect(captured.hasFold, isFalse);
  });
}
