import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_post.freezed.dart';

/// A single ephemeral image posted to a board.
///
/// Content is temporary: [expiresAt] is [createdAt] + the board's retention
/// window (7 days). The view-once behaviour (see `SeenBoardPosts`) is a separate
/// per-session concern and is not stored on the entity.
@freezed
abstract class BoardPost with _$BoardPost {
  const factory BoardPost({
    required String id,
    required String boardId,
    required String authorName,
    required String imageUrl,
    required DateTime createdAt,
    required DateTime expiresAt,
    String? authorAvatarUrl,
    String? caption,
  }) = _BoardPost;
}
