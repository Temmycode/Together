import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:together/core/network/dio_provider.dart';
import 'package:together/features/posts/data/dtos/post_dto.dart';

part 'posts_remote_data_source.g.dart';

/// Talks to the posts HTTP API. Takes [Dio] directly — there is no extra
/// network-wrapper layer.
class PostsRemoteDataSource {
  const PostsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<PostDto>> fetchPosts() async {
    final response = await _dio.get<List<dynamic>>('/posts');
    final data = response.data ?? const [];
    return data
        .map((json) => PostDto.fromJson(json as Map<String, dynamic>))
        .toList(growable: false);
  }
}

@riverpod
PostsRemoteDataSource postsRemoteDataSource(Ref ref) =>
    PostsRemoteDataSource(ref.watch(dioProvider));
