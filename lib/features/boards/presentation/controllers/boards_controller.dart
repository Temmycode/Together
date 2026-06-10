import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/boards/data/repositories/boards_repository_impl.dart';
import 'package:together/features/boards/domain/entities/board.dart';

part 'boards_controller.g.dart';

/// Loads the user's boards as an `AsyncValue`.
///
/// Unwraps the repository [Result] and re-throws the [Failure] so it surfaces as
/// `AsyncError` — the Result↔AsyncValue bridge the UI consumes via `.when(...)`.
@riverpod
class BoardsController extends _$BoardsController {
  @override
  Future<List<Board>> build() => _load();

  Future<List<Board>> _load() async {
    final result = await ref.read(boardsRepositoryProvider).getBoards();
    return switch (result) {
      Ok(:final value) => value,
      Err(:final failure) => throw failure,
    };
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_load);
  }
}
