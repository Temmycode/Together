// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardPost {

 String get id; String get boardId; String get authorName; String get imageUrl; DateTime get createdAt; DateTime get expiresAt; String? get authorAvatarUrl; String? get caption;
/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardPostCopyWith<BoardPost> get copyWith => _$BoardPostCopyWithImpl<BoardPost>(this as BoardPost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardPost&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.caption, caption) || other.caption == caption));
}


@override
int get hashCode => Object.hash(runtimeType,id,boardId,authorName,imageUrl,createdAt,expiresAt,authorAvatarUrl,caption);

@override
String toString() {
  return 'BoardPost(id: $id, boardId: $boardId, authorName: $authorName, imageUrl: $imageUrl, createdAt: $createdAt, expiresAt: $expiresAt, authorAvatarUrl: $authorAvatarUrl, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $BoardPostCopyWith<$Res>  {
  factory $BoardPostCopyWith(BoardPost value, $Res Function(BoardPost) _then) = _$BoardPostCopyWithImpl;
@useResult
$Res call({
 String id, String boardId, String authorName, String imageUrl, DateTime createdAt, DateTime expiresAt, String? authorAvatarUrl, String? caption
});




}
/// @nodoc
class _$BoardPostCopyWithImpl<$Res>
    implements $BoardPostCopyWith<$Res> {
  _$BoardPostCopyWithImpl(this._self, this._then);

  final BoardPost _self;
  final $Res Function(BoardPost) _then;

/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? boardId = null,Object? authorName = null,Object? imageUrl = null,Object? createdAt = null,Object? expiresAt = null,Object? authorAvatarUrl = freezed,Object? caption = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardPost].
extension BoardPostPatterns on BoardPost {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardPost value)  $default,){
final _that = this;
switch (_that) {
case _BoardPost():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardPost value)?  $default,){
final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String boardId,  String authorName,  String imageUrl,  DateTime createdAt,  DateTime expiresAt,  String? authorAvatarUrl,  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that.id,_that.boardId,_that.authorName,_that.imageUrl,_that.createdAt,_that.expiresAt,_that.authorAvatarUrl,_that.caption);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String boardId,  String authorName,  String imageUrl,  DateTime createdAt,  DateTime expiresAt,  String? authorAvatarUrl,  String? caption)  $default,) {final _that = this;
switch (_that) {
case _BoardPost():
return $default(_that.id,_that.boardId,_that.authorName,_that.imageUrl,_that.createdAt,_that.expiresAt,_that.authorAvatarUrl,_that.caption);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String boardId,  String authorName,  String imageUrl,  DateTime createdAt,  DateTime expiresAt,  String? authorAvatarUrl,  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _BoardPost() when $default != null:
return $default(_that.id,_that.boardId,_that.authorName,_that.imageUrl,_that.createdAt,_that.expiresAt,_that.authorAvatarUrl,_that.caption);case _:
  return null;

}
}

}

/// @nodoc


class _BoardPost implements BoardPost {
  const _BoardPost({required this.id, required this.boardId, required this.authorName, required this.imageUrl, required this.createdAt, required this.expiresAt, this.authorAvatarUrl, this.caption});
  

@override final  String id;
@override final  String boardId;
@override final  String authorName;
@override final  String imageUrl;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;
@override final  String? authorAvatarUrl;
@override final  String? caption;

/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardPostCopyWith<_BoardPost> get copyWith => __$BoardPostCopyWithImpl<_BoardPost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardPost&&(identical(other.id, id) || other.id == id)&&(identical(other.boardId, boardId) || other.boardId == boardId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.caption, caption) || other.caption == caption));
}


@override
int get hashCode => Object.hash(runtimeType,id,boardId,authorName,imageUrl,createdAt,expiresAt,authorAvatarUrl,caption);

@override
String toString() {
  return 'BoardPost(id: $id, boardId: $boardId, authorName: $authorName, imageUrl: $imageUrl, createdAt: $createdAt, expiresAt: $expiresAt, authorAvatarUrl: $authorAvatarUrl, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$BoardPostCopyWith<$Res> implements $BoardPostCopyWith<$Res> {
  factory _$BoardPostCopyWith(_BoardPost value, $Res Function(_BoardPost) _then) = __$BoardPostCopyWithImpl;
@override @useResult
$Res call({
 String id, String boardId, String authorName, String imageUrl, DateTime createdAt, DateTime expiresAt, String? authorAvatarUrl, String? caption
});




}
/// @nodoc
class __$BoardPostCopyWithImpl<$Res>
    implements _$BoardPostCopyWith<$Res> {
  __$BoardPostCopyWithImpl(this._self, this._then);

  final _BoardPost _self;
  final $Res Function(_BoardPost) _then;

/// Create a copy of BoardPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? boardId = null,Object? authorName = null,Object? imageUrl = null,Object? createdAt = null,Object? expiresAt = null,Object? authorAvatarUrl = freezed,Object? caption = freezed,}) {
  return _then(_BoardPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,boardId: null == boardId ? _self.boardId : boardId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
