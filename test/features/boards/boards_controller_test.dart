import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/boards/data/repositories/boards_repository_impl.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/domain/repositories/boards_repository.dart';
import 'package:together/features/boards/presentation/controllers/boards_controller.dart';

class _FakeBoardsRepository implements BoardsRepository {
  const _FakeBoardsRepository(this._result);

  final Result<List<Board>> _result;

  @override
  Future<Result<List<Board>>> getBoards() async => _result;

  @override
  Future<Result<Board>> getBoard(String id) async =>
      throw UnimplementedError();

  @override
  Future<Result<List<BoardPost>>> getPosts(String boardId) async =>
      throw UnimplementedError();
}

void main() {
  final board = Board(
    id: 'b1',
    name: 'Test',
    members: const [],
    createdAt: DateTime(2026),
  );

  ProviderContainer containerWith(Result<List<Board>> result) {
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        boardsRepositoryProvider
            .overrideWithValue(_FakeBoardsRepository(result)),
      ],
    );
    addTearDown(container.dispose);
    container.listen(boardsControllerProvider, (_, _) {});
    return container;
  }

  test('exposes the boards as AsyncData on success', () async {
    final container = containerWith(Ok([board]));
    await pumpEventQueue();

    final state = container.read(boardsControllerProvider);
    expect(state, isA<AsyncData<List<Board>>>());
    expect(state.value, [board]);
  });

  test('re-throws the Failure so it surfaces as AsyncError', () async {
    final container = containerWith(const Err(NetworkFailure()));
    await pumpEventQueue();

    final state = container.read(boardsControllerProvider);
    expect(state, isA<AsyncError<List<Board>>>());
    expect((state as AsyncError).error, isA<NetworkFailure>());
  });
}
