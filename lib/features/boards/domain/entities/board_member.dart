import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_member.freezed.dart';

/// A member of a [Board].
///
/// [hasPostedToday] drives the participation indicator on the board card
/// (filled vs empty slots).
@freezed
abstract class BoardMember with _$BoardMember {
  const factory BoardMember({
    required String id,
    required String name,
    String? avatarUrl,
    @Default(false) bool hasPostedToday,
  }) = _BoardMember;
}
