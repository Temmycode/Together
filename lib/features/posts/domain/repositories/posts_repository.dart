import 'package:together/core/error/result.dart';
import 'package:together/features/posts/domain/entities/post.dart';

/// Domain contract for posts.
///
/// The data layer implements it; controllers depend on this interface, never on
/// the implementation. Methods return [Result] so expected failures are values,
/// not thrown exceptions.
abstract interface class PostsRepository {
  Future<Result<List<Post>>> getPosts();
}
