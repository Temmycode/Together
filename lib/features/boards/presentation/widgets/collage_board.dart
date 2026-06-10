import 'package:flutter/material.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/presentation/widgets/collage_placement.dart';
import 'package:together/features/boards/presentation/widgets/collage_tile.dart';

/// The signature board overview: posts as an organic, scrollable pinboard
/// collage — rotated, offset, overlapping tiles rather than a rigid grid.
///
/// Placement is deterministic per post id (see [computeCollageLayout]), so the
/// collage never reshuffles on rebuild, scroll, or hot reload.
class CollageBoard extends StatelessWidget {
  const CollageBoard({super.key, required this.posts, required this.onTapPost});

  final List<BoardPost> posts;
  final void Function(BoardPost post) onTapPost;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(
        child: Text(
          'No moments yet',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    final columns = context.isTablet ? 3 : 2;
    final gutter = context.w(14);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: context.h(8)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final layout = computeCollageLayout(
            ids: posts.map((post) => post.id).toList(growable: false),
            maxWidth: constraints.maxWidth,
            columns: columns,
            gutter: gutter,
          );
          // Paint in z-order so overlaps look organic, not strictly later-on-top.
          final ordered = [...layout.placements]
            ..sort((a, b) => a.z.compareTo(b.z));

          return SizedBox(
            width: constraints.maxWidth,
            height: layout.totalHeight,
            child: Stack(
              children: [
                for (final placement in ordered)
                  Positioned(
                    left: placement.left,
                    top: placement.top,
                    child: Transform.rotate(
                      angle: placement.angle,
                      child: CollageTile(
                        imageUrl: posts[placement.index].imageUrl,
                        width: layout.tileWidth,
                        height: layout.tileHeight,
                        onTap: () => onTapPost(posts[placement.index]),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
