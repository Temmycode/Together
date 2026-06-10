import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/error/exception_mapper.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/boards/data/datasources/boards_mock_data_source.dart';
import 'package:together/features/boards/domain/entities/board.dart';
import 'package:together/features/boards/domain/entities/board_post.dart';
import 'package:together/features/boards/domain/repositories/boards_repository.dart';

part 'boards_repository_impl.g.dart';

/// Default [BoardsRepository], backed by the in-memory mock data source. Any
/// thrown error is converted to a typed [Failure] via the [mapErrorToFailure]
/// seam, exactly like the network-backed posts repository.
class BoardsRepositoryImpl implements BoardsRepository {
  const BoardsRepositoryImpl(this._source);

  final BoardsMockDataSource _source;

  @override
  Future<Result<List<Board>>> getBoards() async {
    try {
      return Ok(await _source.fetchBoards());
    } catch (error) {
      return Err(mapErrorToFailure(error));
    }
  }

  @override
  Future<Result<Board>> getBoard(String id) async {
    try {
      return Ok(await _source.fetchBoard(id));
    } catch (error) {
      return Err(mapErrorToFailure(error));
    }
  }

  @override
  Future<Result<List<BoardPost>>> getPosts(String boardId) async {
    try {
      return Ok(await _source.fetchPosts(boardId));
    } catch (error) {
      return Err(mapErrorToFailure(error));
    }
  }
}

/// Binds the [BoardsRepository] interface to its implementation. Controllers
/// watch this and receive the interface type.
@riverpod
BoardsRepository boardsRepository(Ref ref) =>
    BoardsRepositoryImpl(ref.watch(boardsMockDataSourceProvider));
