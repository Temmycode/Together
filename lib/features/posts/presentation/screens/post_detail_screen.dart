import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:together/features/posts/domain/entities/post.dart';
import 'package:together/features/posts/presentation/controllers/posts_controller.dart';
import 'package:together/features/posts/presentation/widgets/post_detail_view.dart';

/// Phone route target for a single post. Looks the post up in the already
/// loaded list (the tablet two-pane layout shows detail inline instead).
class PostDetailScreen extends ConsumerWidget {
  const PostDetailScreen({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsControllerProvider).value ?? const <Post>[];
    Post? post;
    for (final candidate in posts) {
      if (candidate.id == postId) {
        post = candidate;
        break;
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text(post?.title ?? 'Post')),
      body: PostDetailView(post: post),
    );
  }
}
