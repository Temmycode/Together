// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Board {

 String get id; String get name; List<BoardMember> get members; DateTime get createdAt; String? get prompt; List<String> get coverImageUrls;
/// Create a copy of Board
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardCopyWith<Board> get copyWith => _$BoardCopyWithImpl<Board>(this as Board, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Board&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other.coverImageUrls, coverImageUrls));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(members),createdAt,prompt,const DeepCollectionEquality().hash(coverImageUrls));

@override
String toString() {
  return 'Board(id: $id, name: $name, members: $members, createdAt: $createdAt, prompt: $prompt, coverImageUrls: $coverImageUrls)';
}


}

/// @nodoc
abstract mixin class $BoardCopyWith<$Res>  {
  factory $BoardCopyWith(Board value, $Res Function(Board) _then) = _$BoardCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<BoardMember> members, DateTime createdAt, String? prompt, List<String> coverImageUrls
});




}
/// @nodoc
class _$BoardCopyWithImpl<$Res>
    implements $BoardCopyWith<$Res> {
  _$BoardCopyWithImpl(this._self, this._then);

  final Board _self;
  final $Res Function(Board) _then;

/// Create a copy of Board
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? members = null,Object? createdAt = null,Object? prompt = freezed,Object? coverImageUrls = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<BoardMember>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrls: null == coverImageUrls ? _self.coverImageUrls : coverImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Board].
extension BoardPatterns on Board {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Board value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Board() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Board value)  $default,){
final _that = this;
switch (_that) {
case _Board():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Board value)?  $default,){
final _that = this;
switch (_that) {
case _Board() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<BoardMember> members,  DateTime createdAt,  String? prompt,  List<String> coverImageUrls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Board() when $default != null:
return $default(_that.id,_that.name,_that.members,_that.createdAt,_that.prompt,_that.coverImageUrls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<BoardMember> members,  DateTime createdAt,  String? prompt,  List<String> coverImageUrls)  $default,) {final _that = this;
switch (_that) {
case _Board():
return $default(_that.id,_that.name,_that.members,_that.createdAt,_that.prompt,_that.coverImageUrls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<BoardMember> members,  DateTime createdAt,  String? prompt,  List<String> coverImageUrls)?  $default,) {final _that = this;
switch (_that) {
case _Board() when $default != null:
return $default(_that.id,_that.name,_that.members,_that.createdAt,_that.prompt,_that.coverImageUrls);case _:
  return null;

}
}

}

/// @nodoc


class _Board implements Board {
  const _Board({required this.id, required this.name, required final  List<BoardMember> members, required this.createdAt, this.prompt, final  List<String> coverImageUrls = const <String>[]}): _members = members,_coverImageUrls = coverImageUrls;
  

@override final  String id;
@override final  String name;
 final  List<BoardMember> _members;
@override List<BoardMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  DateTime createdAt;
@override final  String? prompt;
 final  List<String> _coverImageUrls;
@override@JsonKey() List<String> get coverImageUrls {
  if (_coverImageUrls is EqualUnmodifiableListView) return _coverImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coverImageUrls);
}


/// Create a copy of Board
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardCopyWith<_Board> get copyWith => __$BoardCopyWithImpl<_Board>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Board&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other._coverImageUrls, _coverImageUrls));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_members),createdAt,prompt,const DeepCollectionEquality().hash(_coverImageUrls));

@override
String toString() {
  return 'Board(id: $id, name: $name, members: $members, createdAt: $createdAt, prompt: $prompt, coverImageUrls: $coverImageUrls)';
}


}

/// @nodoc
abstract mixin class _$BoardCopyWith<$Res> implements $BoardCopyWith<$Res> {
  factory _$BoardCopyWith(_Board value, $Res Function(_Board) _then) = __$BoardCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<BoardMember> members, DateTime createdAt, String? prompt, List<String> coverImageUrls
});




}
/// @nodoc
class __$BoardCopyWithImpl<$Res>
    implements _$BoardCopyWith<$Res> {
  __$BoardCopyWithImpl(this._self, this._then);

  final _Board _self;
  final $Res Function(_Board) _then;

/// Create a copy of Board
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? members = null,Object? createdAt = null,Object? prompt = freezed,Object? coverImageUrls = null,}) {
  return _then(_Board(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<BoardMember>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,prompt: freezed == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrls: null == coverImageUrls ? _self._coverImageUrls : coverImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
