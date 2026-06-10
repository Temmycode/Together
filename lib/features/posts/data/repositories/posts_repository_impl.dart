import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/error/exception_mapper.dart';
import 'package:together/core/error/result.dart';
import 'package:together/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:together/features/posts/domain/entities/post.dart';
import 'package:together/features/posts/domain/repositories/posts_repository.dart';

part 'posts_repository_impl.g.dart';

/// Default [PostsRepository]: fetches DTOs, maps them to domain entities, and
/// converts any thrown exception into a typed [Failure] via the
/// [mapErrorToFailure] seam.
class PostsRepositoryImpl implements PostsRepository {
  const PostsRepositoryImpl(this._remote);

  final PostsRemoteDataSource _remote;

  @override
  Future<Result<List<Post>>> getPosts() async {
    try {
      final dtos = await _remote.fetchPosts();
      return Ok(dtos.map((dto) => dto.toDomain()).toList(growable: false));
    } catch (error) {
      return Err(mapErrorToFailure(error));
    }
  }
}

/// Binds the [PostsRepository] interface to its implementation. Controllers
/// watch this and receive the interface type.
@riverpod
PostsRepository postsRepository(Ref ref) =>
    PostsRepositoryImpl(ref.watch(postsRemoteDataSourceProvider));
