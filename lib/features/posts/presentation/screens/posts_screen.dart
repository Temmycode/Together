import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:together/core/error/result.dart';
import 'package:together/core/responsive/context_extensions.dart';
import 'package:together/core/responsive/responsive_layout.dart';
import 'package:together/core/router/routes.dart';
import 'package:together/core/theme/theme_provider.dart';
import 'package:together/core/widgets/app_error_view.dart';
import 'package:together/core/widgets/app_loader.dart';
import 'package:together/features/posts/domain/entities/post.dart';
import 'package:together/features/posts/presentation/controllers/posts_controller.dart';
import 'package:together/features/posts/presentation/widgets/post_card.dart';
import 'package:together/features/posts/presentation/widgets/post_detail_view.dart';

/// Home screen: a responsive list of posts.
///
/// Phone → single-column list; tapping pushes the detail route.
/// Tablet / foldable → a [TwoPane] master–detail, laid out around any hinge.
class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            icon: const Icon(Icons.brightness_6_outlined),
            onPressed: () =>
                ref.read(themeModeControllerProvider.notifier).toggle(),
          ),
        ],
      ),
      body: postsAsync.when(
        loading: () => const AppLoader(),
        error: (error, _) => AppErrorView(
          message: error is Failure ? error.message : 'Could not load posts.',
          onRetry: () => ref.read(postsControllerProvider.notifier).refresh(),
        ),
        data: (posts) => RefreshIndicator(
          onRefresh: () => ref.read(postsControllerProvider.notifier).refresh(),
          child: ResponsiveLayout(
            phone: (_) => _PostsList(
              posts: posts,
              onTap: (post) => context.push(Routes.postDetailPath(post.id)),
            ),
            tablet: (_) => _PostsTwoPane(posts: posts),
          ),
        ),
      ),
    );
  }
}

class _PostsList extends StatelessWidget {
  const _PostsList({required this.posts, required this.onTap, this.selectedId});

  final List<Post> posts;
  final void Function(Post post) onTap;
  final int? selectedId;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(context.w(16)),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: posts.length,
      separatorBuilder: (_, _) => SizedBox(height: context.h(12)),
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          post: post,
          selected: post.id == selectedId,
          onTap: () => onTap(post),
        );
      },
    );
  }
}

class _PostsTwoPane extends ConsumerWidget {
  const _PostsTwoPane({required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId =
        ref.watch(selectedPostIdProvider) ??
        (posts.isNotEmpty ? posts.first.id : null);
    Post? selected;
    for (final post in posts) {
      if (post.id == selectedId) {
        selected = post;
        break;
      }
    }
    return TwoPane(
      start: _PostsList(
        posts: posts,
        selectedId: selectedId,
        onTap: (post) =>
            ref.read(selectedPostIdProvider.notifier).select(post.id),
      ),
      end: PostDetailView(post: selected),
    );
  }
}
