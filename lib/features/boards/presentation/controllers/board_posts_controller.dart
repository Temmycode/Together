import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/boards/data/repositories/boards_repository_impl.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';

part 'board_posts_controller.g.dart';

/// Loads the posts for a single board (family, keyed by [boardId]).
///
/// Same Result↔AsyncValue bridge as [BoardsController]. The view-once filtering
/// lives in `unseenBoardPostsProvider`, not here — this controller always
/// exposes the full board.
@riverpod
class BoardPostsController extends _$BoardPostsController {
  @override
  Future<List<BoardPost>> build(String boardId) => _load(boardId);

  Future<List<BoardPost>> _load(String boardId) async {
    final result = await ref.read(boardsRepositoryProvider).getPosts(boardId);
    return switch (result) {
      Ok(:final value) => value,
      Err(:final failure) => throw failure,
    };
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _load(boardId));
  }
}
