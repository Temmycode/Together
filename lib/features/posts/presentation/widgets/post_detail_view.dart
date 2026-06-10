import 'package:flutter/material.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/features/posts/domain/entities/post.dart';

/// Detail content for a post, reused by the phone detail screen and the
/// tablet/foldable two-pane layout. Shows a placeholder when [post] is null.
class PostDetailView extends StatelessWidget {
  const PostDetailView({super.key, this.post});

  final Post? post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final post = this.post;
    if (post == null) {
      return Center(
        child: Text('Select a post', style: theme.textTheme.bodyLarge),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.w(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title, style: theme.textTheme.headlineSmall),
          SizedBox(height: context.h(8)),
          Text(
            'Post #${post.id} · User ${post.userId}',
            style: theme.textTheme.labelMedium
                ?.copyWith(color: theme.colorScheme.primary),
          ),
          SizedBox(height: context.h(16)),
          Text(post.body, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
