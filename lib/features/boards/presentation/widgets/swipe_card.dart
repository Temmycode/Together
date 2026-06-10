import 'package:flutter/material.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/presentation/widgets/network_image_placeholder.dart';

/// A full-bleed card for the swipe viewer: the image with a bottom gradient
/// carrying author, caption, and the expiry countdown.
class SwipeCard extends StatelessWidget {
  const SwipeCard({super.key, required this.post});

  final BoardPost post;

  @override
  Widget build(BuildContext context) {
    final radius = context.w(24);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: ColoredBox(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeNetworkImage(url: post.imageUrl),
            // Bottom scrim so text stays legible over any image.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
            Positioned(
              left: context.w(20),
              right: context.w(20),
              bottom: context.h(24),
              child: _CardMeta(post: post),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardMeta extends StatelessWidget {
  const _CardMeta({required this.post});

  final BoardPost post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _Avatar(url: post.authorAvatarUrl, size: context.w(34)),
            SizedBox(width: context.w(10)),
            Text(
              post.authorName,
              style: TextStyle(
                color: Colors.white,
                fontSize: context.sp(16),
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            _ExpiryChip(expiresAt: post.expiresAt),
          ],
        ),
        if (post.caption != null) ...[
          SizedBox(height: context.h(10)),
          Text(
            post.caption!,
            style: TextStyle(color: Colors.white, fontSize: context.sp(15)),
          ),
        ],
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.size});

  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white24,
      ),
      clipBehavior: Clip.antiAlias,
      child: url == null
          ? Icon(Icons.person, color: Colors.white, size: size * 0.6)
          : SafeNetworkImage(url: url!),
    );
  }
}

class _ExpiryChip extends StatelessWidget {
  const _ExpiryChip({required this.expiresAt});

  final DateTime expiresAt;

  String get _label {
    final left = expiresAt.difference(DateTime.now());
    if (left.isNegative) return 'Expired';
    if (left.inDays >= 1) return '${left.inDays}d left';
    if (left.inHours >= 1) return '${left.inHours}h left';
    return 'Expires soon';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(10),
        vertical: context.h(5),
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(context.w(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, color: Colors.white, size: context.sp(14)),
          SizedBox(width: context.w(5)),
          Text(
            _label,
            style: TextStyle(color: Colors.white, fontSize: context.sp(12)),
          ),
        ],
      ),
    );
  }
}
