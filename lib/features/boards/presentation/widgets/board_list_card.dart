import 'package:flutter/material.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/presentation/widgets/network_image_placeholder.dart';

/// A board on the home list: a stacked-collage preview, the board name + prompt,
/// member avatars, and participation dots (filled = posted today).
class BoardListCard extends StatelessWidget {
  const BoardListCard({super.key, required this.board, this.onTap});

  final Board board;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(context.w(14)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CollagePreview(imageUrls: board.coverImageUrls, size: context.w(92)),
              SizedBox(width: context.w(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      board.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (board.prompt != null) ...[
                      SizedBox(height: context.h(4)),
                      Text(
                        board.prompt!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    SizedBox(height: context.h(12)),
                    _Participation(board: board),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A tiny pile of up to three rotated thumbnails — the pinboard feel in miniature.
class _CollagePreview extends StatelessWidget {
  const _CollagePreview({required this.imageUrls, required this.size});

  final List<String> imageUrls;
  final double size;

  @override
  Widget build(BuildContext context) {
    final urls = imageUrls.take(3).toList(growable: false);
    final tile = size * 0.7;
    const angles = [-0.18, 0.0, 0.16];

    return SizedBox(
      width: size,
      height: size,
      child: urls.isEmpty
          ? const NetworkImagePlaceholder()
          : Stack(
              alignment: Alignment.center,
              children: [
                for (var i = urls.length - 1; i >= 0; i--)
                  Transform.rotate(
                    angle: angles[i % angles.length],
                    child: Container(
                      width: tile,
                      height: tile,
                      padding: EdgeInsets.all(context.w(3)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(context.w(8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: context.w(6),
                            offset: Offset(0, context.h(2)),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(context.w(5)),
                        child: SafeNetworkImage(url: urls[i]),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _Participation extends StatelessWidget {
  const _Participation({required this.board});

  final Board board;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final postedCount = board.members.where((m) => m.hasPostedToday).length;
    return Row(
      children: [
        for (final member in board.members)
          Padding(
            padding: EdgeInsets.only(right: context.w(6)),
            child: Container(
              width: context.w(9),
              height: context.w(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: member.hasPostedToday
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                border: Border.all(
                  color: theme.colorScheme.outlineVariant,
                  width: 0.5,
                ),
              ),
            ),
          ),
        SizedBox(width: context.w(4)),
        Text(
          '$postedCount/${board.members.length} today',
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
