import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/presentation/controllers/board_posts_controller.dart';

part 'seen_board_posts.g.dart';

/// The set of post ids the user has already swiped past this app session.
///
/// `keepAlive` is essential: an auto-dispose notifier would reset when the
/// viewer screen is popped, defeating the view-once rule. As a session-scoped
/// (in-memory) set, it resets on a full app restart — consistent with the
/// ephemeral product.
@Riverpod(keepAlive: true)
class SeenBoardPosts extends _$SeenBoardPosts {
  @override
  Set<String> build() => const {};

  void markSeen(String id) {
    if (state.contains(id)) return; // idempotent
    state = {...state, id}; // new instance -> notifies listeners
  }
}

/// The unseen posts for a board — what the viewer actually displays. Recomputes
/// whenever the board loads or a post is marked seen.
@riverpod
List<BoardPost> unseenBoardPosts(Ref ref, String boardId) {
  final all =
      ref.watch(boardPostsControllerProvider(boardId)).value ??
      const <BoardPost>[];
  final seen = ref.watch(seenBoardPostsProvider);
  return all.where((post) => !seen.contains(post.id)).toList(growable: false);
}
