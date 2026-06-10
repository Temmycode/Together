import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/boards/data/repositories/boards_repository_impl.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/domain/repositories/boards_repository.dart';
import 'package:together/features/boards/presentation/controllers/board_posts_controller.dart';
import 'package:together/features/boards/presentation/controllers/seen_board_posts.dart';

class _FakeBoardsRepository implements BoardsRepository {
  const _FakeBoardsRepository(this._posts);

  final List<BoardPost> _posts;

  @override
  Future<Result<List<Board>>> getBoards() async => const Ok([]);

  @override
  Future<Result<Board>> getBoard(String id) async =>
      throw UnimplementedError();

  @override
  Future<Result<List<BoardPost>>> getPosts(String boardId) async => Ok(_posts);
}

void main() {
  final p1 = BoardPost(
    id: 'p1',
    boardId: 'b',
    authorName: 'A',
    imageUrl: 'x',
    createdAt: DateTime(2026),
    expiresAt: DateTime(2026, 1, 8),
  );
  final p2 = p1.copyWith(id: 'p2');

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        boardsRepositoryProvider
            .overrideWithValue(_FakeBoardsRepository([p1, p2])),
      ],
    );
    addTearDown(container.dispose);
    container.listen(boardPostsControllerProvider('b'), (_, _) {});
    return container;
  }

  test('unseen excludes seen posts and markSeen is idempotent', () async {
    final container = makeContainer();
    await pumpEventQueue();

    expect(container.read(unseenBoardPostsProvider('b')).length, 2);

    container.read(seenBoardPostsProvider.notifier).markSeen('p1');
    expect(
      container.read(unseenBoardPostsProvider('b')).map((p) => p.id).toList(),
      ['p2'],
    );

    // Marking the same id again is a no-op.
    container.read(seenBoardPostsProvider.notifier).markSeen('p1');
    expect(container.read(seenBoardPostsProvider).length, 1);

    container.read(seenBoardPostsProvider.notifier).markSeen('p2');
    expect(container.read(unseenBoardPostsProvider('b')), isEmpty);
  });
}
