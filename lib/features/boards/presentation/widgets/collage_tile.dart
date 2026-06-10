import 'package:flutter/material.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/features/boards/presentation/widgets/network_image_placeholder.dart';

/// A single pinboard tile: a rounded image with a white border and soft shadow,
/// giving the polaroid / pinned-photo feel. Tapping enters the viewer.
class CollageTile extends StatelessWidget {
  const CollageTile({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.onTap,
  });

  final String imageUrl;
  final double width;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final border = context.w(6);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(border),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.w(14)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: context.w(12),
              offset: Offset(0, context.h(6)),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(context.w(9)),
          child: SafeNetworkImage(url: imageUrl),
        ),
      ),
    );
  }
}
