import 'package:flutter/material.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/features/posts/domain/entities/post.dart';

/// A tappable card showing a post's title and a snippet of its body.
class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    this.selected = false,
    this.onTap,
  });

  final Post post;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: selected ? theme.colorScheme.secondaryContainer : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(context.w(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: context.h(8)),
              Text(
                post.body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
