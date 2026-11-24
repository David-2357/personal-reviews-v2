// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder_explorer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FolderExplorerConfig {

 bool get groupByFolders; int? get folderId; bool get includeDeleted; bool get excludeNonDeleted; bool get showSearch; bool get showSort; bool get showFilter; bool get showCategoriesFilter; bool get showVisibilityFilter; ElementsFilter get defaultFilter; ElementsSort get defaultSort;
/// Create a copy of FolderExplorerConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderExplorerConfigCopyWith<FolderExplorerConfig> get copyWith => _$FolderExplorerConfigCopyWithImpl<FolderExplorerConfig>(this as FolderExplorerConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderExplorerConfig&&(identical(other.groupByFolders, groupByFolders) || other.groupByFolders == groupByFolders)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.includeDeleted, includeDeleted) || other.includeDeleted == includeDeleted)&&(identical(other.excludeNonDeleted, excludeNonDeleted) || other.excludeNonDeleted == excludeNonDeleted)&&(identical(other.showSearch, showSearch) || other.showSearch == showSearch)&&(identical(other.showSort, showSort) || other.showSort == showSort)&&(identical(other.showFilter, showFilter) || other.showFilter == showFilter)&&(identical(other.showCategoriesFilter, showCategoriesFilter) || other.showCategoriesFilter == showCategoriesFilter)&&(identical(other.showVisibilityFilter, showVisibilityFilter) || other.showVisibilityFilter == showVisibilityFilter)&&(identical(other.defaultFilter, defaultFilter) || other.defaultFilter == defaultFilter)&&(identical(other.defaultSort, defaultSort) || other.defaultSort == defaultSort));
}


@override
int get hashCode => Object.hash(runtimeType,groupByFolders,folderId,includeDeleted,excludeNonDeleted,showSearch,showSort,showFilter,showCategoriesFilter,showVisibilityFilter,defaultFilter,defaultSort);

@override
String toString() {
  return 'FolderExplorerConfig(groupByFolders: $groupByFolders, folderId: $folderId, includeDeleted: $includeDeleted, excludeNonDeleted: $excludeNonDeleted, showSearch: $showSearch, showSort: $showSort, showFilter: $showFilter, showCategoriesFilter: $showCategoriesFilter, showVisibilityFilter: $showVisibilityFilter, defaultFilter: $defaultFilter, defaultSort: $defaultSort)';
}


}

/// @nodoc
abstract mixin class $FolderExplorerConfigCopyWith<$Res>  {
  factory $FolderExplorerConfigCopyWith(FolderExplorerConfig value, $Res Function(FolderExplorerConfig) _then) = _$FolderExplorerConfigCopyWithImpl;
@useResult
$Res call({
 bool groupByFolders, int? folderId, bool includeDeleted, bool excludeNonDeleted, bool showSearch, bool showSort, bool showFilter, bool showCategoriesFilter, bool showVisibilityFilter, ElementsFilter defaultFilter, ElementsSort defaultSort
});




}
/// @nodoc
class _$FolderExplorerConfigCopyWithImpl<$Res>
    implements $FolderExplorerConfigCopyWith<$Res> {
  _$FolderExplorerConfigCopyWithImpl(this._self, this._then);

  final FolderExplorerConfig _self;
  final $Res Function(FolderExplorerConfig) _then;

/// Create a copy of FolderExplorerConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupByFolders = null,Object? folderId = freezed,Object? includeDeleted = null,Object? excludeNonDeleted = null,Object? showSearch = null,Object? showSort = null,Object? showFilter = null,Object? showCategoriesFilter = null,Object? showVisibilityFilter = null,Object? defaultFilter = null,Object? defaultSort = null,}) {
  return _then(_self.copyWith(
groupByFolders: null == groupByFolders ? _self.groupByFolders : groupByFolders // ignore: cast_nullable_to_non_nullable
as bool,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as int?,includeDeleted: null == includeDeleted ? _self.includeDeleted : includeDeleted // ignore: cast_nullable_to_non_nullable
as bool,excludeNonDeleted: null == excludeNonDeleted ? _self.excludeNonDeleted : excludeNonDeleted // ignore: cast_nullable_to_non_nullable
as bool,showSearch: null == showSearch ? _self.showSearch : showSearch // ignore: cast_nullable_to_non_nullable
as bool,showSort: null == showSort ? _self.showSort : showSort // ignore: cast_nullable_to_non_nullable
as bool,showFilter: null == showFilter ? _self.showFilter : showFilter // ignore: cast_nullable_to_non_nullable
as bool,showCategoriesFilter: null == showCategoriesFilter ? _self.showCategoriesFilter : showCategoriesFilter // ignore: cast_nullable_to_non_nullable
as bool,showVisibilityFilter: null == showVisibilityFilter ? _self.showVisibilityFilter : showVisibilityFilter // ignore: cast_nullable_to_non_nullable
as bool,defaultFilter: null == defaultFilter ? _self.defaultFilter : defaultFilter // ignore: cast_nullable_to_non_nullable
as ElementsFilter,defaultSort: null == defaultSort ? _self.defaultSort : defaultSort // ignore: cast_nullable_to_non_nullable
as ElementsSort,
  ));
}

}


/// Adds pattern-matching-related methods to [FolderExplorerConfig].
extension FolderExplorerConfigPatterns on FolderExplorerConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderExplorerConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderExplorerConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderExplorerConfig value)  $default,){
final _that = this;
switch (_that) {
case _FolderExplorerConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderExplorerConfig value)?  $default,){
final _that = this;
switch (_that) {
case _FolderExplorerConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool groupByFolders,  int? folderId,  bool includeDeleted,  bool excludeNonDeleted,  bool showSearch,  bool showSort,  bool showFilter,  bool showCategoriesFilter,  bool showVisibilityFilter,  ElementsFilter defaultFilter,  ElementsSort defaultSort)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderExplorerConfig() when $default != null:
return $default(_that.groupByFolders,_that.folderId,_that.includeDeleted,_that.excludeNonDeleted,_that.showSearch,_that.showSort,_that.showFilter,_that.showCategoriesFilter,_that.showVisibilityFilter,_that.defaultFilter,_that.defaultSort);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool groupByFolders,  int? folderId,  bool includeDeleted,  bool excludeNonDeleted,  bool showSearch,  bool showSort,  bool showFilter,  bool showCategoriesFilter,  bool showVisibilityFilter,  ElementsFilter defaultFilter,  ElementsSort defaultSort)  $default,) {final _that = this;
switch (_that) {
case _FolderExplorerConfig():
return $default(_that.groupByFolders,_that.folderId,_that.includeDeleted,_that.excludeNonDeleted,_that.showSearch,_that.showSort,_that.showFilter,_that.showCategoriesFilter,_that.showVisibilityFilter,_that.defaultFilter,_that.defaultSort);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool groupByFolders,  int? folderId,  bool includeDeleted,  bool excludeNonDeleted,  bool showSearch,  bool showSort,  bool showFilter,  bool showCategoriesFilter,  bool showVisibilityFilter,  ElementsFilter defaultFilter,  ElementsSort defaultSort)?  $default,) {final _that = this;
switch (_that) {
case _FolderExplorerConfig() when $default != null:
return $default(_that.groupByFolders,_that.folderId,_that.includeDeleted,_that.excludeNonDeleted,_that.showSearch,_that.showSort,_that.showFilter,_that.showCategoriesFilter,_that.showVisibilityFilter,_that.defaultFilter,_that.defaultSort);case _:
  return null;

}
}

}

/// @nodoc


class _FolderExplorerConfig implements FolderExplorerConfig {
  const _FolderExplorerConfig({this.groupByFolders = true, this.folderId, this.includeDeleted = false, this.excludeNonDeleted = false, this.showSearch = true, this.showSort = true, this.showFilter = true, this.showCategoriesFilter = true, this.showVisibilityFilter = true, this.defaultFilter = const ElementsFilter(), this.defaultSort = const ElementsSort()});
  

@override@JsonKey() final  bool groupByFolders;
@override final  int? folderId;
@override@JsonKey() final  bool includeDeleted;
@override@JsonKey() final  bool excludeNonDeleted;
@override@JsonKey() final  bool showSearch;
@override@JsonKey() final  bool showSort;
@override@JsonKey() final  bool showFilter;
@override@JsonKey() final  bool showCategoriesFilter;
@override@JsonKey() final  bool showVisibilityFilter;
@override@JsonKey() final  ElementsFilter defaultFilter;
@override@JsonKey() final  ElementsSort defaultSort;

/// Create a copy of FolderExplorerConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderExplorerConfigCopyWith<_FolderExplorerConfig> get copyWith => __$FolderExplorerConfigCopyWithImpl<_FolderExplorerConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderExplorerConfig&&(identical(other.groupByFolders, groupByFolders) || other.groupByFolders == groupByFolders)&&(identical(other.folderId, folderId) || other.folderId == folderId)&&(identical(other.includeDeleted, includeDeleted) || other.includeDeleted == includeDeleted)&&(identical(other.excludeNonDeleted, excludeNonDeleted) || other.excludeNonDeleted == excludeNonDeleted)&&(identical(other.showSearch, showSearch) || other.showSearch == showSearch)&&(identical(other.showSort, showSort) || other.showSort == showSort)&&(identical(other.showFilter, showFilter) || other.showFilter == showFilter)&&(identical(other.showCategoriesFilter, showCategoriesFilter) || other.showCategoriesFilter == showCategoriesFilter)&&(identical(other.showVisibilityFilter, showVisibilityFilter) || other.showVisibilityFilter == showVisibilityFilter)&&(identical(other.defaultFilter, defaultFilter) || other.defaultFilter == defaultFilter)&&(identical(other.defaultSort, defaultSort) || other.defaultSort == defaultSort));
}


@override
int get hashCode => Object.hash(runtimeType,groupByFolders,folderId,includeDeleted,excludeNonDeleted,showSearch,showSort,showFilter,showCategoriesFilter,showVisibilityFilter,defaultFilter,defaultSort);

@override
String toString() {
  return 'FolderExplorerConfig(groupByFolders: $groupByFolders, folderId: $folderId, includeDeleted: $includeDeleted, excludeNonDeleted: $excludeNonDeleted, showSearch: $showSearch, showSort: $showSort, showFilter: $showFilter, showCategoriesFilter: $showCategoriesFilter, showVisibilityFilter: $showVisibilityFilter, defaultFilter: $defaultFilter, defaultSort: $defaultSort)';
}


}

/// @nodoc
abstract mixin class _$FolderExplorerConfigCopyWith<$Res> implements $FolderExplorerConfigCopyWith<$Res> {
  factory _$FolderExplorerConfigCopyWith(_FolderExplorerConfig value, $Res Function(_FolderExplorerConfig) _then) = __$FolderExplorerConfigCopyWithImpl;
@override @useResult
$Res call({
 bool groupByFolders, int? folderId, bool includeDeleted, bool excludeNonDeleted, bool showSearch, bool showSort, bool showFilter, bool showCategoriesFilter, bool showVisibilityFilter, ElementsFilter defaultFilter, ElementsSort defaultSort
});




}
/// @nodoc
class __$FolderExplorerConfigCopyWithImpl<$Res>
    implements _$FolderExplorerConfigCopyWith<$Res> {
  __$FolderExplorerConfigCopyWithImpl(this._self, this._then);

  final _FolderExplorerConfig _self;
  final $Res Function(_FolderExplorerConfig) _then;

/// Create a copy of FolderExplorerConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupByFolders = null,Object? folderId = freezed,Object? includeDeleted = null,Object? excludeNonDeleted = null,Object? showSearch = null,Object? showSort = null,Object? showFilter = null,Object? showCategoriesFilter = null,Object? showVisibilityFilter = null,Object? defaultFilter = null,Object? defaultSort = null,}) {
  return _then(_FolderExplorerConfig(
groupByFolders: null == groupByFolders ? _self.groupByFolders : groupByFolders // ignore: cast_nullable_to_non_nullable
as bool,folderId: freezed == folderId ? _self.folderId : folderId // ignore: cast_nullable_to_non_nullable
as int?,includeDeleted: null == includeDeleted ? _self.includeDeleted : includeDeleted // ignore: cast_nullable_to_non_nullable
as bool,excludeNonDeleted: null == excludeNonDeleted ? _self.excludeNonDeleted : excludeNonDeleted // ignore: cast_nullable_to_non_nullable
as bool,showSearch: null == showSearch ? _self.showSearch : showSearch // ignore: cast_nullable_to_non_nullable
as bool,showSort: null == showSort ? _self.showSort : showSort // ignore: cast_nullable_to_non_nullable
as bool,showFilter: null == showFilter ? _self.showFilter : showFilter // ignore: cast_nullable_to_non_nullable
as bool,showCategoriesFilter: null == showCategoriesFilter ? _self.showCategoriesFilter : showCategoriesFilter // ignore: cast_nullable_to_non_nullable
as bool,showVisibilityFilter: null == showVisibilityFilter ? _self.showVisibilityFilter : showVisibilityFilter // ignore: cast_nullable_to_non_nullable
as bool,defaultFilter: null == defaultFilter ? _self.defaultFilter : defaultFilter // ignore: cast_nullable_to_non_nullable
as ElementsFilter,defaultSort: null == defaultSort ? _self.defaultSort : defaultSort // ignore: cast_nullable_to_non_nullable
as ElementsSort,
  ));
}


}

/// @nodoc
mixin _$FolderExplorerData {

 bool get hasFolders; bool get hasItems; List<FolderDetailed> get folders; List<ItemWithLastReview> get items;
/// Create a copy of FolderExplorerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderExplorerDataCopyWith<FolderExplorerData> get copyWith => _$FolderExplorerDataCopyWithImpl<FolderExplorerData>(this as FolderExplorerData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderExplorerData&&(identical(other.hasFolders, hasFolders) || other.hasFolders == hasFolders)&&(identical(other.hasItems, hasItems) || other.hasItems == hasItems)&&const DeepCollectionEquality().equals(other.folders, folders)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,hasFolders,hasItems,const DeepCollectionEquality().hash(folders),const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'FolderExplorerData(hasFolders: $hasFolders, hasItems: $hasItems, folders: $folders, items: $items)';
}


}

/// @nodoc
abstract mixin class $FolderExplorerDataCopyWith<$Res>  {
  factory $FolderExplorerDataCopyWith(FolderExplorerData value, $Res Function(FolderExplorerData) _then) = _$FolderExplorerDataCopyWithImpl;
@useResult
$Res call({
 bool hasFolders, bool hasItems, List<FolderDetailed> folders, List<ItemWithLastReview> items
});




}
/// @nodoc
class _$FolderExplorerDataCopyWithImpl<$Res>
    implements $FolderExplorerDataCopyWith<$Res> {
  _$FolderExplorerDataCopyWithImpl(this._self, this._then);

  final FolderExplorerData _self;
  final $Res Function(FolderExplorerData) _then;

/// Create a copy of FolderExplorerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasFolders = null,Object? hasItems = null,Object? folders = null,Object? items = null,}) {
  return _then(_self.copyWith(
hasFolders: null == hasFolders ? _self.hasFolders : hasFolders // ignore: cast_nullable_to_non_nullable
as bool,hasItems: null == hasItems ? _self.hasItems : hasItems // ignore: cast_nullable_to_non_nullable
as bool,folders: null == folders ? _self.folders : folders // ignore: cast_nullable_to_non_nullable
as List<FolderDetailed>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ItemWithLastReview>,
  ));
}

}


/// Adds pattern-matching-related methods to [FolderExplorerData].
extension FolderExplorerDataPatterns on FolderExplorerData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderExplorerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderExplorerData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderExplorerData value)  $default,){
final _that = this;
switch (_that) {
case _FolderExplorerData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderExplorerData value)?  $default,){
final _that = this;
switch (_that) {
case _FolderExplorerData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasFolders,  bool hasItems,  List<FolderDetailed> folders,  List<ItemWithLastReview> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderExplorerData() when $default != null:
return $default(_that.hasFolders,_that.hasItems,_that.folders,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasFolders,  bool hasItems,  List<FolderDetailed> folders,  List<ItemWithLastReview> items)  $default,) {final _that = this;
switch (_that) {
case _FolderExplorerData():
return $default(_that.hasFolders,_that.hasItems,_that.folders,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasFolders,  bool hasItems,  List<FolderDetailed> folders,  List<ItemWithLastReview> items)?  $default,) {final _that = this;
switch (_that) {
case _FolderExplorerData() when $default != null:
return $default(_that.hasFolders,_that.hasItems,_that.folders,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _FolderExplorerData implements FolderExplorerData {
  const _FolderExplorerData({this.hasFolders = false, this.hasItems = false, final  List<FolderDetailed> folders = const [], final  List<ItemWithLastReview> items = const []}): _folders = folders,_items = items;
  

@override@JsonKey() final  bool hasFolders;
@override@JsonKey() final  bool hasItems;
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


/// Create a copy of FolderExplorerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderExplorerDataCopyWith<_FolderExplorerData> get copyWith => __$FolderExplorerDataCopyWithImpl<_FolderExplorerData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderExplorerData&&(identical(other.hasFolders, hasFolders) || other.hasFolders == hasFolders)&&(identical(other.hasItems, hasItems) || other.hasItems == hasItems)&&const DeepCollectionEquality().equals(other._folders, _folders)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,hasFolders,hasItems,const DeepCollectionEquality().hash(_folders),const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'FolderExplorerData(hasFolders: $hasFolders, hasItems: $hasItems, folders: $folders, items: $items)';
}


}

/// @nodoc
abstract mixin class _$FolderExplorerDataCopyWith<$Res> implements $FolderExplorerDataCopyWith<$Res> {
  factory _$FolderExplorerDataCopyWith(_FolderExplorerData value, $Res Function(_FolderExplorerData) _then) = __$FolderExplorerDataCopyWithImpl;
@override @useResult
$Res call({
 bool hasFolders, bool hasItems, List<FolderDetailed> folders, List<ItemWithLastReview> items
});




}
/// @nodoc
class __$FolderExplorerDataCopyWithImpl<$Res>
    implements _$FolderExplorerDataCopyWith<$Res> {
  __$FolderExplorerDataCopyWithImpl(this._self, this._then);

  final _FolderExplorerData _self;
  final $Res Function(_FolderExplorerData) _then;

/// Create a copy of FolderExplorerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasFolders = null,Object? hasItems = null,Object? folders = null,Object? items = null,}) {
  return _then(_FolderExplorerData(
hasFolders: null == hasFolders ? _self.hasFolders : hasFolders // ignore: cast_nullable_to_non_nullable
as bool,hasItems: null == hasItems ? _self.hasItems : hasItems // ignore: cast_nullable_to_non_nullable
as bool,folders: null == folders ? _self._folders : folders // ignore: cast_nullable_to_non_nullable
as List<FolderDetailed>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ItemWithLastReview>,
  ));
}


}

/// @nodoc
mixin _$FolderExplorerParams {

 FolderExplorerConfig get config; FolderExplorerData get data;
/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FolderExplorerParamsCopyWith<FolderExplorerParams> get copyWith => _$FolderExplorerParamsCopyWithImpl<FolderExplorerParams>(this as FolderExplorerParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FolderExplorerParams&&(identical(other.config, config) || other.config == config)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,config,data);

@override
String toString() {
  return 'FolderExplorerParams(config: $config, data: $data)';
}


}

/// @nodoc
abstract mixin class $FolderExplorerParamsCopyWith<$Res>  {
  factory $FolderExplorerParamsCopyWith(FolderExplorerParams value, $Res Function(FolderExplorerParams) _then) = _$FolderExplorerParamsCopyWithImpl;
@useResult
$Res call({
 FolderExplorerConfig config, FolderExplorerData data
});


$FolderExplorerConfigCopyWith<$Res> get config;$FolderExplorerDataCopyWith<$Res> get data;

}
/// @nodoc
class _$FolderExplorerParamsCopyWithImpl<$Res>
    implements $FolderExplorerParamsCopyWith<$Res> {
  _$FolderExplorerParamsCopyWithImpl(this._self, this._then);

  final FolderExplorerParams _self;
  final $Res Function(FolderExplorerParams) _then;

/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? config = null,Object? data = null,}) {
  return _then(_self.copyWith(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as FolderExplorerConfig,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FolderExplorerData,
  ));
}
/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderExplorerConfigCopyWith<$Res> get config {
  
  return $FolderExplorerConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderExplorerDataCopyWith<$Res> get data {
  
  return $FolderExplorerDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [FolderExplorerParams].
extension FolderExplorerParamsPatterns on FolderExplorerParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FolderExplorerParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FolderExplorerParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FolderExplorerParams value)  $default,){
final _that = this;
switch (_that) {
case _FolderExplorerParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FolderExplorerParams value)?  $default,){
final _that = this;
switch (_that) {
case _FolderExplorerParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FolderExplorerConfig config,  FolderExplorerData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FolderExplorerParams() when $default != null:
return $default(_that.config,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FolderExplorerConfig config,  FolderExplorerData data)  $default,) {final _that = this;
switch (_that) {
case _FolderExplorerParams():
return $default(_that.config,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FolderExplorerConfig config,  FolderExplorerData data)?  $default,) {final _that = this;
switch (_that) {
case _FolderExplorerParams() when $default != null:
return $default(_that.config,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _FolderExplorerParams implements FolderExplorerParams {
  const _FolderExplorerParams({required this.config, required this.data});
  

@override final  FolderExplorerConfig config;
@override final  FolderExplorerData data;

/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FolderExplorerParamsCopyWith<_FolderExplorerParams> get copyWith => __$FolderExplorerParamsCopyWithImpl<_FolderExplorerParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FolderExplorerParams&&(identical(other.config, config) || other.config == config)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,config,data);

@override
String toString() {
  return 'FolderExplorerParams(config: $config, data: $data)';
}


}

/// @nodoc
abstract mixin class _$FolderExplorerParamsCopyWith<$Res> implements $FolderExplorerParamsCopyWith<$Res> {
  factory _$FolderExplorerParamsCopyWith(_FolderExplorerParams value, $Res Function(_FolderExplorerParams) _then) = __$FolderExplorerParamsCopyWithImpl;
@override @useResult
$Res call({
 FolderExplorerConfig config, FolderExplorerData data
});


@override $FolderExplorerConfigCopyWith<$Res> get config;@override $FolderExplorerDataCopyWith<$Res> get data;

}
/// @nodoc
class __$FolderExplorerParamsCopyWithImpl<$Res>
    implements _$FolderExplorerParamsCopyWith<$Res> {
  __$FolderExplorerParamsCopyWithImpl(this._self, this._then);

  final _FolderExplorerParams _self;
  final $Res Function(_FolderExplorerParams) _then;

/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? config = null,Object? data = null,}) {
  return _then(_FolderExplorerParams(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as FolderExplorerConfig,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FolderExplorerData,
  ));
}

/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderExplorerConfigCopyWith<$Res> get config {
  
  return $FolderExplorerConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}/// Create a copy of FolderExplorerParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FolderExplorerDataCopyWith<$Res> get data {
  
  return $FolderExplorerDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
