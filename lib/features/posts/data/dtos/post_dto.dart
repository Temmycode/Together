import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:together/features/posts/domain/entities/post.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

/// Wire model for a post (matches the JSONPlaceholder `/posts` shape).
///
/// Kept separate from the [Post] domain entity so an API change doesn't ripple
/// into the UI — map across the boundary with [toDomain]. For features where
/// the API and UI shapes are identical, collapsing the two into one class is a
/// reasonable simplification.
@freezed
abstract class PostDto with _$PostDto {
  const PostDto._();

  const factory PostDto({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  Post toDomain() => Post(id: id, userId: userId, title: title, body: body);
}
