import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:together/features/boards/domain/entities/board_member.dart';

part 'board.freezed.dart';

/// A private, shared board — the collaborative space members post into daily.
///
/// Domain entity, serialization-free. [coverImageUrls] are a few recent image
/// URLs used to render the stacked-collage preview on the home list without
/// loading the full post set.
@freezed
abstract class Board with _$Board {
  const factory Board({
    required String id,
    required String name,
    required List<BoardMember> members,
    required DateTime createdAt,
    String? prompt,
    @Default(<String>[]) List<String> coverImageUrls,
  }) = _Board;
}
