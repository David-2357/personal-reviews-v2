// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FolderDomain {

 int get id; String get name; String? get imagePath; int? get parentId; DateTime get createdAt; bool get isDeleted; DateTime? get deletedAt;
/// Create a copy of FolderDomain
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderDomainCopyWith<FolderDomain> get copyWith => _$FolderDomainCopyWithImpl<FolderDomain>(this as FolderDomain, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderDomain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,imagePath,parentId,createdAt,isDeleted,deletedAt);

@override
String toString() {
  return 'FolderDomain(id: $id, name: $name, imagePath: $imagePath, parentId: $parentId, createdAt: $createdAt, isDeleted: $isDeleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $FolderDomainCopyWith<$Res>  {
  factory $FolderDomainCopyWith(FolderDomain value, $Res Function(FolderDomain) _then) = _$FolderDomainCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? imagePath, int? parentId, DateTime createdAt, bool isDeleted, DateTime? deletedAt
});




}
/// @nodoc
class _$FolderDomainCopyWithImpl<$Res>
    implements $FolderDomainCopyWith<$Res> {
  _$FolderDomainCopyWithImpl(this._self, this._then);

  final FolderDomain _self;
  final $Res Function(FolderDomain) _then;

/// Create a copy of FolderDomain
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? imagePath = freezed,Object? parentId = freezed,Object? createdAt = null,Object? isDeleted = null,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FolderDomain].
extension FolderDomainPatterns on FolderDomain {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderDomain value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderDomain() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderDomain value)  $default,){
final _that = this;
switch (_that) {
case _FolderDomain():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderDomain value)?  $default,){
final _that = this;
switch (_that) {
case _FolderDomain() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? imagePath,  int? parentId,  DateTime createdAt,  bool isDeleted,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderDomain() when $default != null:
return $default(_that.id,_that.name,_that.imagePath,_that.parentId,_that.createdAt,_that.isDeleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? imagePath,  int? parentId,  DateTime createdAt,  bool isDeleted,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _FolderDomain():
return $default(_that.id,_that.name,_that.imagePath,_that.parentId,_that.createdAt,_that.isDeleted,_that.deletedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? imagePath,  int? parentId,  DateTime createdAt,  bool isDeleted,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _FolderDomain() when $default != null:
return $default(_that.id,_that.name,_that.imagePath,_that.parentId,_that.createdAt,_that.isDeleted,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FolderDomain implements FolderDomain {
  const _FolderDomain({required this.id, required this.name, this.imagePath, this.parentId, required this.createdAt, this.isDeleted = false, this.deletedAt});
  

@override final  int id;
@override final  String name;
@override final  String? imagePath;
@override final  int? parentId;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isDeleted;
@override final  DateTime? deletedAt;

/// Create a copy of FolderDomain
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderDomainCopyWith<_FolderDomain> get copyWith => __$FolderDomainCopyWithImpl<_FolderDomain>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderDomain&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,imagePath,parentId,createdAt,isDeleted,deletedAt);

@override
String toString() {
  return 'FolderDomain(id: $id, name: $name, imagePath: $imagePath, parentId: $parentId, createdAt: $createdAt, isDeleted: $isDeleted, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$FolderDomainCopyWith<$Res> implements $FolderDomainCopyWith<$Res> {
  factory _$FolderDomainCopyWith(_FolderDomain value, $Res Function(_FolderDomain) _then) = __$FolderDomainCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? imagePath, int? parentId, DateTime createdAt, bool isDeleted, DateTime? deletedAt
});




}
/// @nodoc
class __$FolderDomainCopyWithImpl<$Res>
    implements _$FolderDomainCopyWith<$Res> {
  __$FolderDomainCopyWithImpl(this._self, this._then);

  final _FolderDomain _self;
  final $Res Function(_FolderDomain) _then;

/// Create a copy of FolderDomain
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? imagePath = freezed,Object? parentId = freezed,Object? createdAt = null,Object? isDeleted = null,Object? deletedAt = freezed,}) {
  return _then(_FolderDomain(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$FolderDetailed {

 FolderDomain get folder; int get itemCount; List<String> get previewImages;
/// Create a copy of FolderDetailed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderDetailedCopyWith<FolderDetailed> get copyWith => _$FolderDetailedCopyWithImpl<FolderDetailed>(this as FolderDetailed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderDetailed&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&const DeepCollectionEquality().equals(other.previewImages, previewImages));
}


@override
int get hashCode => Object.hash(runtimeType,folder,itemCount,const DeepCollectionEquality().hash(previewImages));

@override
String toString() {
  return 'FolderDetailed(folder: $folder, itemCount: $itemCount, previewImages: $previewImages)';
}


}

/// @nodoc
abstract mixin class $FolderDetailedCopyWith<$Res>  {
  factory $FolderDetailedCopyWith(FolderDetailed value, $Res Function(FolderDetailed) _then) = _$FolderDetailedCopyWithImpl;
@useResult
$Res call({
 FolderDomain folder, int itemCount, List<String> previewImages
});


$FolderDomainCopyWith<$Res> get folder;

}
/// @nodoc
class _$FolderDetailedCopyWithImpl<$Res>
    implements $FolderDetailedCopyWith<$Res> {
  _$FolderDetailedCopyWithImpl(this._self, this._then);

  final FolderDetailed _self;
  final $Res Function(FolderDetailed) _then;

/// Create a copy of FolderDetailed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? folder = null,Object? itemCount = null,Object? previewImages = null,}) {
  return _then(_self.copyWith(
folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as FolderDomain,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,previewImages: null == previewImages ? _self.previewImages : previewImages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of FolderDetailed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderDomainCopyWith<$Res> get folder {
  
  return $FolderDomainCopyWith<$Res>(_self.folder, (value) {
    return _then(_self.copyWith(folder: value));
  });
}
}


/// Adds pattern-matching-related methods to [FolderDetailed].
extension FolderDetailedPatterns on FolderDetailed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderDetailed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderDetailed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderDetailed value)  $default,){
final _that = this;
switch (_that) {
case _FolderDetailed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderDetailed value)?  $default,){
final _that = this;
switch (_that) {
case _FolderDetailed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FolderDomain folder,  int itemCount,  List<String> previewImages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderDetailed() when $default != null:
return $default(_that.folder,_that.itemCount,_that.previewImages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FolderDomain folder,  int itemCount,  List<String> previewImages)  $default,) {final _that = this;
switch (_that) {
case _FolderDetailed():
return $default(_that.folder,_that.itemCount,_that.previewImages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FolderDomain folder,  int itemCount,  List<String> previewImages)?  $default,) {final _that = this;
switch (_that) {
case _FolderDetailed() when $default != null:
return $default(_that.folder,_that.itemCount,_that.previewImages);case _:
  return null;

}
}

}

/// @nodoc


class _FolderDetailed implements FolderDetailed {
  const _FolderDetailed({required this.folder, required this.itemCount, required final  List<String> previewImages}): _previewImages = previewImages;
  

@override final  FolderDomain folder;
@override final  int itemCount;
 final  List<String> _previewImages;
@override List<String> get previewImages {
  if (_previewImages is EqualUnmodifiableListView) return _previewImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_previewImages);
}


/// Create a copy of FolderDetailed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderDetailedCopyWith<_FolderDetailed> get copyWith => __$FolderDetailedCopyWithImpl<_FolderDetailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderDetailed&&(identical(other.folder, folder) || other.folder == folder)&&(identical(other.itemCount, itemCount) || other.itemCount == itemCount)&&const DeepCollectionEquality().equals(other._previewImages, _previewImages));
}


@override
int get hashCode => Object.hash(runtimeType,folder,itemCount,const DeepCollectionEquality().hash(_previewImages));

@override
String toString() {
  return 'FolderDetailed(folder: $folder, itemCount: $itemCount, previewImages: $previewImages)';
}


}

/// @nodoc
abstract mixin class _$FolderDetailedCopyWith<$Res> implements $FolderDetailedCopyWith<$Res> {
  factory _$FolderDetailedCopyWith(_FolderDetailed value, $Res Function(_FolderDetailed) _then) = __$FolderDetailedCopyWithImpl;
@override @useResult
$Res call({
 FolderDomain folder, int itemCount, List<String> previewImages
});


@override $FolderDomainCopyWith<$Res> get folder;

}
/// @nodoc
class __$FolderDetailedCopyWithImpl<$Res>
    implements _$FolderDetailedCopyWith<$Res> {
  __$FolderDetailedCopyWithImpl(this._self, this._then);

  final _FolderDetailed _self;
  final $Res Function(_FolderDetailed) _then;

/// Create a copy of FolderDetailed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? folder = null,Object? itemCount = null,Object? previewImages = null,}) {
  return _then(_FolderDetailed(
folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as FolderDomain,itemCount: null == itemCount ? _self.itemCount : itemCount // ignore: cast_nullable_to_non_nullable
as int,previewImages: null == previewImages ? _self._previewImages : previewImages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of FolderDetailed
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderDomainCopyWith<$Res> get folder {
  
  return $FolderDomainCopyWith<$Res>(_self.folder, (value) {
    return _then(_self.copyWith(folder: value));
  });
}
}

/// @nodoc
mixin _$FolderWithChildren {

 FolderDomain get folder; List<FolderWithChildren> get children;
/// Create a copy of FolderWithChildren
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderWithChildrenCopyWith<FolderWithChildren> get copyWith => _$FolderWithChildrenCopyWithImpl<FolderWithChildren>(this as FolderWithChildren, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderWithChildren&&(identical(other.folder, folder) || other.folder == folder)&&const DeepCollectionEquality().equals(other.children, children));
}


@override
int get hashCode => Object.hash(runtimeType,folder,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'FolderWithChildren(folder: $folder, children: $children)';
}


}

/// @nodoc
abstract mixin class $FolderWithChildrenCopyWith<$Res>  {
  factory $FolderWithChildrenCopyWith(FolderWithChildren value, $Res Function(FolderWithChildren) _then) = _$FolderWithChildrenCopyWithImpl;
@useResult
$Res call({
 FolderDomain folder, List<FolderWithChildren> children
});


$FolderDomainCopyWith<$Res> get folder;

}
/// @nodoc
class _$FolderWithChildrenCopyWithImpl<$Res>
    implements $FolderWithChildrenCopyWith<$Res> {
  _$FolderWithChildrenCopyWithImpl(this._self, this._then);

  final FolderWithChildren _self;
  final $Res Function(FolderWithChildren) _then;

/// Create a copy of FolderWithChildren
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? folder = null,Object? children = null,}) {
  return _then(_self.copyWith(
folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as FolderDomain,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<FolderWithChildren>,
  ));
}
/// Create a copy of FolderWithChildren
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderDomainCopyWith<$Res> get folder {
  
  return $FolderDomainCopyWith<$Res>(_self.folder, (value) {
    return _then(_self.copyWith(folder: value));
  });
}
}


/// Adds pattern-matching-related methods to [FolderWithChildren].
extension FolderWithChildrenPatterns on FolderWithChildren {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderWithChildren value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderWithChildren() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderWithChildren value)  $default,){
final _that = this;
switch (_that) {
case _FolderWithChildren():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderWithChildren value)?  $default,){
final _that = this;
switch (_that) {
case _FolderWithChildren() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FolderDomain folder,  List<FolderWithChildren> children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderWithChildren() when $default != null:
return $default(_that.folder,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FolderDomain folder,  List<FolderWithChildren> children)  $default,) {final _that = this;
switch (_that) {
case _FolderWithChildren():
return $default(_that.folder,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FolderDomain folder,  List<FolderWithChildren> children)?  $default,) {final _that = this;
switch (_that) {
case _FolderWithChildren() when $default != null:
return $default(_that.folder,_that.children);case _:
  return null;

}
}

}

/// @nodoc


class _FolderWithChildren implements FolderWithChildren {
  const _FolderWithChildren({required this.folder, final  List<FolderWithChildren> children = const []}): _children = children;
  

@override final  FolderDomain folder;
 final  List<FolderWithChildren> _children;
@override@JsonKey() List<FolderWithChildren> get children {
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_children);
}


/// Create a copy of FolderWithChildren
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderWithChildrenCopyWith<_FolderWithChildren> get copyWith => __$FolderWithChildrenCopyWithImpl<_FolderWithChildren>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderWithChildren&&(identical(other.folder, folder) || other.folder == folder)&&const DeepCollectionEquality().equals(other._children, _children));
}


@override
int get hashCode => Object.hash(runtimeType,folder,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'FolderWithChildren(folder: $folder, children: $children)';
}


}

/// @nodoc
abstract mixin class _$FolderWithChildrenCopyWith<$Res> implements $FolderWithChildrenCopyWith<$Res> {
  factory _$FolderWithChildrenCopyWith(_FolderWithChildren value, $Res Function(_FolderWithChildren) _then) = __$FolderWithChildrenCopyWithImpl;
@override @useResult
$Res call({
 FolderDomain folder, List<FolderWithChildren> children
});


@override $FolderDomainCopyWith<$Res> get folder;

}
/// @nodoc
class __$FolderWithChildrenCopyWithImpl<$Res>
    implements _$FolderWithChildrenCopyWith<$Res> {
  __$FolderWithChildrenCopyWithImpl(this._self, this._then);

  final _FolderWithChildren _self;
  final $Res Function(_FolderWithChildren) _then;

/// Create a copy of FolderWithChildren
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? folder = null,Object? children = null,}) {
  return _then(_FolderWithChildren(
folder: null == folder ? _self.folder : folder // ignore: cast_nullable_to_non_nullable
as FolderDomain,children: null == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<FolderWithChildren>,
  ));
}

/// Create a copy of FolderWithChildren
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderDomainCopyWith<$Res> get folder {
  
  return $FolderDomainCopyWith<$Res>(_self.folder, (value) {
    return _then(_self.copyWith(folder: value));
  });
}
}

/// @nodoc
mixin _$FolderContent {

 List<FolderDetailed> get folders; List<ItemWithLastReview> get items;
/// Create a copy of FolderContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderContentCopyWith<FolderContent> get copyWith => _$FolderContentCopyWithImpl<FolderContent>(this as FolderContent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderContent&&const DeepCollectionEquality().equals(other.folders, folders)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(folders),const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'FolderContent(folders: $folders, items: $items)';
}


}

/// @nodoc
abstract mixin class $FolderContentCopyWith<$Res>  {
  factory $FolderContentCopyWith(FolderContent value, $Res Function(FolderContent) _then) = _$FolderContentCopyWithImpl;
@useResult
$Res call({
 List<FolderDetailed> folders, List<ItemWithLastReview> items
});




}
/// @nodoc
class _$FolderContentCopyWithImpl<$Res>
    implements $FolderContentCopyWith<$Res> {
  _$FolderContentCopyWithImpl(this._self, this._then);

  final FolderContent _self;
  final $Res Function(FolderContent) _then;

/// Create a copy of FolderContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? folders = null,Object? items = null,}) {
  return _then(_self.copyWith(
folders: null == folders ? _self.folders : folders // ignore: cast_nullable_to_non_nullable
as List<FolderDetailed>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ItemWithLastReview>,
  ));
}

}


/// Adds pattern-matching-related methods to [FolderContent].
extension FolderContentPatterns on FolderContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderContent value)  $default,){
final _that = this;
switch (_that) {
case _FolderContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderContent value)?  $default,){
final _that = this;
switch (_that) {
case _FolderContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FolderDetailed> folders,  List<ItemWithLastReview> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderContent() when $default != null:
return $default(_that.folders,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FolderDetailed> folders,  List<ItemWithLastReview> items)  $default,) {final _that = this;
switch (_that) {
case _FolderContent():
return $default(_that.folders,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FolderDetailed> folders,  List<ItemWithLastReview> items)?  $default,) {final _that = this;
switch (_that) {
case _FolderContent() when $default != null:
return $default(_that.folders,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _FolderContent implements FolderContent {
  const _FolderContent({final  List<FolderDetailed> folders = const [], final  List<ItemWithLastReview> items = const []}): _folders = folders,_items = items;
  

 final  List<FolderDetailed> _folders;
@override@JsonKey() List<FolderDetailed> get folders {
  if (_folders is EqualUnmodifiableListView) return _folders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_folders);
}

 final  List<ItemWithLastReview> _items;
@override@JsonKey() List<ItemWithLastReview> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of FolderContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderContentCopyWith<_FolderContent> get copyWith => __$FolderContentCopyWithImpl<_FolderContent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderContent&&const DeepCollectionEquality().equals(other._folders, _folders)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_folders),const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'FolderContent(folders: $folders, items: $items)';
}


}

/// @nodoc
abstract mixin class _$FolderContentCopyWith<$Res> implements $FolderContentCopyWith<$Res> {
  factory _$FolderContentCopyWith(_FolderContent value, $Res Function(_FolderContent) _then) = __$FolderContentCopyWithImpl;
@override @useResult
$Res call({
 List<FolderDetailed> folders, List<ItemWithLastReview> items
});




}
/// @nodoc
class __$FolderContentCopyWithImpl<$Res>
    implements _$FolderContentCopyWith<$Res> {
  __$FolderContentCopyWithImpl(this._self, this._then);

  final _FolderContent _self;
  final $Res Function(_FolderContent) _then;

/// Create a copy of FolderContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? folders = null,Object? items = null,}) {
  return _then(_FolderContent(
folders: null == folders ? _self._folders : folders // ignore: cast_nullable_to_non_nullable
as List<FolderDetailed>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ItemWithLastReview>,
  ));
}


}

// dart format on
