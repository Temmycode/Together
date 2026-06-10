import 'dart:math' as math;

/// Where a single collage tile sits, derived deterministically from a post id.
class CollageTilePlacement {
  const CollageTilePlacement({
    required this.index,
    required this.left,
    required this.top,
    required this.angle,
    required this.z,
  });

  /// Index into the original posts list (stable; selects which image to draw).
  final int index;
  final double left;
  final double top;

  /// Rotation in radians (~±5°).
  final double angle;

  /// Paint order; higher draws on top. Decorrelates overlap from list order.
  final double z;
}

/// The full computed layout for a collage: tile geometry + total scroll height.
class CollageLayout {
  const CollageLayout({
    required this.placements,
    required this.tileWidth,
    required this.tileHeight,
    required this.totalHeight,
  });

  final List<CollageTilePlacement> placements;
  final double tileWidth;
  final double tileHeight;
  final double totalHeight;
}

/// A tiny deterministic PRNG (xorshift) seeded by a post id's [hashCode].
///
/// Successive [next] draws are decorrelated, so one seed yields independent
/// jitter / rotation / z values. Uses no `Random`/`DateTime`, so identical input
/// always produces identical output — the collage never reshuffles on rebuild.
/// (Stable within a single isolate run, not across runs; do not persist or
/// assert on literal positions across runs.)
class _CollageRng {
  _CollageRng(int seed) : _state = _normalize(seed);

  int _state;

  static int _normalize(int seed) {
    final s = seed & 0x7fffffffffffffff;
    return s == 0 ? 0x2545f4914f6cdd1d : s;
  }

  double next() {
    var x = _state;
    x ^= (x << 13) & 0x7fffffffffffffff;
    x ^= x >> 7;
    x ^= (x << 17) & 0x7fffffffffffffff;
    _state = x;
    return (x & 0xffffff) / 0x1000000; // 24 bits -> [0, 1)
  }
}

/// Computes an organic, grid-anchored collage layout.
///
/// Tiles are anchored to grid cells (so none is ever fully occluded) while
/// per-id jitter, rotation, and overlap kill the rigid grid look. Pure and
/// deterministic per [ids] — see [_CollageRng].
CollageLayout computeCollageLayout({
  required List<String> ids,
  required double maxWidth,
  required int columns,
  required double gutter,
}) {
  final cols = columns < 1 ? 1 : columns;
  final cellW = (maxWidth - gutter * (cols + 1)) / cols;
  final tileW = cellW * 1.12; // wider than the cell => slight horizontal overlap
  final tileH = tileW * 4 / 3; // matches the 600x800 placeholder aspect
  final rowStep = tileH * 0.78; // shorter than the tile => vertical overlap
  final maxLeft = math.max(0.0, maxWidth - tileW);

  final placements = <CollageTilePlacement>[];
  for (var i = 0; i < ids.length; i++) {
    final rng = _CollageRng(ids[i].hashCode);
    final col = i % cols;
    final row = i ~/ cols;
    final cellX = gutter + col * (cellW + gutter);
    final jx = (rng.next() - 0.5) * gutter * 2.0;
    final jy = (rng.next() - 0.5) * rowStep * 0.30;
    final left = (cellX + (cellW - tileW) / 2 + jx).clamp(0.0, maxLeft).toDouble();
    final top = row * rowStep + jy + gutter;
    final angle = (rng.next() - 0.5) * 0.18; // ~±5.2°
    final z = rng.next();
    placements.add(
      CollageTilePlacement(index: i, left: left, top: top, angle: angle, z: z),
    );
  }

  final rows = ids.isEmpty ? 0 : (ids.length + cols - 1) ~/ cols;
  final totalHeight = rows * rowStep + tileH * 0.30 + gutter * 2;
  return CollageLayout(
    placements: placements,
    tileWidth: tileW,
    tileHeight: tileH,
    totalHeight: totalHeight,
  );
}
