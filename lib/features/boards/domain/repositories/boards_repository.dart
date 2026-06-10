import 'package:together/core/error/result.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';

/// Domain contract for boards.
///
/// The data layer implements it; controllers depend on this interface, never on
/// the implementation. Methods return [Result] so expected failures are values,
/// not thrown exceptions. A real backend impl can be swapped in behind this
/// without touching the presentation layer.
abstract interface class BoardsRepository {
  Future<Result<List<Board>>> getBoards();
  Future<Result<Board>> getBoard(String id);
  Future<Result<List<BoardPost>>> getPosts(String boardId);
}
