import 'package:flutter_test/flutter_test.dart';
import 'package:together/features/boards/presentation/widgets/collage_placement.dart';

void main() {
  group('computeCollageLayout', () {
    const maxWidth = 390.0;
    const columns = 2;
    const gutter = 14.0;

    test('is deterministic for the same ids', () {
      final ids = ['a', 'b', 'c', 'd', 'e'];
      final first = computeCollageLayout(
        ids: ids,
        maxWidth: maxWidth,
        columns: columns,
        gutter: gutter,
      );
      final second = computeCollageLayout(
        ids: ids,
        maxWidth: maxWidth,
        columns: columns,
        gutter: gutter,
      );

      for (var i = 0; i < ids.length; i++) {
        expect(first.placements[i].left, second.placements[i].left);
        expect(first.placements[i].top, second.placements[i].top);
        expect(first.placements[i].angle, second.placements[i].angle);
        expect(first.placements[i].z, second.placements[i].z);
      }
    });

    test('keeps every tile within the horizontal bounds', () {
      final ids = List.generate(12, (i) => 'post-$i');
      final layout = computeCollageLayout(
        ids: ids,
        maxWidth: maxWidth,
        columns: columns,
        gutter: gutter,
      );

      for (final placement in layout.placements) {
        expect(placement.left, greaterThanOrEqualTo(0));
        expect(
          placement.left + layout.tileWidth,
          lessThanOrEqualTo(maxWidth + 0.001),
        );
      }
    });

    test('rotation stays gentle (well under ±0.1 rad)', () {
      final layout = computeCollageLayout(
        ids: const ['x', 'y', 'z'],
        maxWidth: maxWidth,
        columns: columns,
        gutter: gutter,
      );
      for (final placement in layout.placements) {
        expect(placement.angle.abs(), lessThan(0.1));
      }
    });

    test('empty ids yields no placements', () {
      final layout = computeCollageLayout(
        ids: const [],
        maxWidth: maxWidth,
        columns: columns,
        gutter: gutter,
      );
      expect(layout.placements, isEmpty);
      expect(layout.totalHeight, greaterThanOrEqualTo(0));
    });
  });
}
