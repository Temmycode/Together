// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BoardMember {

 String get id; String get name; String? get avatarUrl; bool get hasPostedToday;
/// Create a copy of BoardMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoardMemberCopyWith<BoardMember> get copyWith => _$BoardMemberCopyWithImpl<BoardMember>(this as BoardMember, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BoardMember&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.hasPostedToday, hasPostedToday) || other.hasPostedToday == hasPostedToday));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,hasPostedToday);

@override
String toString() {
  return 'BoardMember(id: $id, name: $name, avatarUrl: $avatarUrl, hasPostedToday: $hasPostedToday)';
}


}

/// @nodoc
abstract mixin class $BoardMemberCopyWith<$Res>  {
  factory $BoardMemberCopyWith(BoardMember value, $Res Function(BoardMember) _then) = _$BoardMemberCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? avatarUrl, bool hasPostedToday
});




}
/// @nodoc
class _$BoardMemberCopyWithImpl<$Res>
    implements $BoardMemberCopyWith<$Res> {
  _$BoardMemberCopyWithImpl(this._self, this._then);

  final BoardMember _self;
  final $Res Function(BoardMember) _then;

/// Create a copy of BoardMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,Object? hasPostedToday = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,hasPostedToday: null == hasPostedToday ? _self.hasPostedToday : hasPostedToday // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BoardMember].
extension BoardMemberPatterns on BoardMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BoardMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BoardMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BoardMember value)  $default,){
final _that = this;
switch (_that) {
case _BoardMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BoardMember value)?  $default,){
final _that = this;
switch (_that) {
case _BoardMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? avatarUrl,  bool hasPostedToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BoardMember() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.hasPostedToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? avatarUrl,  bool hasPostedToday)  $default,) {final _that = this;
switch (_that) {
case _BoardMember():
return $default(_that.id,_that.name,_that.avatarUrl,_that.hasPostedToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? avatarUrl,  bool hasPostedToday)?  $default,) {final _that = this;
switch (_that) {
case _BoardMember() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.hasPostedToday);case _:
  return null;

}
}

}

/// @nodoc


class _BoardMember implements BoardMember {
  const _BoardMember({required this.id, required this.name, this.avatarUrl, this.hasPostedToday = false});
  

@override final  String id;
@override final  String name;
@override final  String? avatarUrl;
@override@JsonKey() final  bool hasPostedToday;

/// Create a copy of BoardMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoardMemberCopyWith<_BoardMember> get copyWith => __$BoardMemberCopyWithImpl<_BoardMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BoardMember&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.hasPostedToday, hasPostedToday) || other.hasPostedToday == hasPostedToday));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,hasPostedToday);

@override
String toString() {
  return 'BoardMember(id: $id, name: $name, avatarUrl: $avatarUrl, hasPostedToday: $hasPostedToday)';
}


}

/// @nodoc
abstract mixin class _$BoardMemberCopyWith<$Res> implements $BoardMemberCopyWith<$Res> {
  factory _$BoardMemberCopyWith(_BoardMember value, $Res Function(_BoardMember) _then) = __$BoardMemberCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? avatarUrl, bool hasPostedToday
});




}
/// @nodoc
class __$BoardMemberCopyWithImpl<$Res>
    implements _$BoardMemberCopyWith<$Res> {
  __$BoardMemberCopyWithImpl(this._self, this._then);

  final _BoardMember _self;
  final $Res Function(_BoardMember) _then;

/// Create a copy of BoardMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,Object? hasPostedToday = null,}) {
  return _then(_BoardMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,hasPostedToday: null == hasPostedToday ? _self.hasPostedToday : hasPostedToday // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
