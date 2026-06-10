import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// A post in the feed.
///
/// Domain entity — pure and serialization-free. The data layer's `PostDto`
/// maps into this via `toDomain()`.
@freezed
abstract class Post with _$Post {
  const factory Post({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _Post;
}
