// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repo_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RepoSearchResult _$RepoSearchResultFromJson(Map<String, dynamic> json) {
  return _RepoSearchResult.fromJson(json);
}

/// @nodoc
mixin _$RepoSearchResult {
  int get totalCount => throw _privateConstructorUsedError;
  bool get incompleteResults => throw _privateConstructorUsedError;
  List<Repo> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepoSearchResultCopyWith<RepoSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepoSearchResultCopyWith<$Res> {
  factory $RepoSearchResultCopyWith(
          RepoSearchResult value, $Res Function(RepoSearchResult) then) =
      _$RepoSearchResultCopyWithImpl<$Res, RepoSearchResult>;
  @useResult
  $Res call({int totalCount, bool incompleteResults, List<Repo> items});
}

/// @nodoc
class _$RepoSearchResultCopyWithImpl<$Res, $Val extends RepoSearchResult>
    implements $RepoSearchResultCopyWith<$Res> {
  _$RepoSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? incompleteResults = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteResults: null == incompleteResults
          ? _value.incompleteResults
          : incompleteResults // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepoSearchResultImplCopyWith<$Res>
    implements $RepoSearchResultCopyWith<$Res> {
  factory _$$RepoSearchResultImplCopyWith(_$RepoSearchResultImpl value,
          $Res Function(_$RepoSearchResultImpl) then) =
      __$$RepoSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalCount, bool incompleteResults, List<Repo> items});
}

/// @nodoc
class __$$RepoSearchResultImplCopyWithImpl<$Res>
    extends _$RepoSearchResultCopyWithImpl<$Res, _$RepoSearchResultImpl>
    implements _$$RepoSearchResultImplCopyWith<$Res> {
  __$$RepoSearchResultImplCopyWithImpl(_$RepoSearchResultImpl _value,
      $Res Function(_$RepoSearchResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? incompleteResults = null,
    Object? items = null,
  }) {
    return _then(_$RepoSearchResultImpl(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteResults: null == incompleteResults
          ? _value.incompleteResults
          : incompleteResults // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Repo>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class _$RepoSearchResultImpl implements _RepoSearchResult {
  const _$RepoSearchResultImpl(
      {required this.totalCount,
      required this.incompleteResults,
      required final List<Repo> items})
      : _items = items;

  factory _$RepoSearchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepoSearchResultImplFromJson(json);

  @override
  final int totalCount;
  @override
  final bool incompleteResults;
  final List<Repo> _items;
  @override
  List<Repo> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'RepoSearchResult(totalCount: $totalCount, incompleteResults: $incompleteResults, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepoSearchResultImpl &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.incompleteResults, incompleteResults) ||
                other.incompleteResults == incompleteResults) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, totalCount, incompleteResults,
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepoSearchResultImplCopyWith<_$RepoSearchResultImpl> get copyWith =>
      __$$RepoSearchResultImplCopyWithImpl<_$RepoSearchResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepoSearchResultImplToJson(
      this,
    );
  }
}

abstract class _RepoSearchResult implements RepoSearchResult {
  const factory _RepoSearchResult(
      {required final int totalCount,
      required final bool incompleteResults,
      required final List<Repo> items}) = _$RepoSearchResultImpl;

  factory _RepoSearchResult.fromJson(Map<String, dynamic> json) =
      _$RepoSearchResultImpl.fromJson;

  @override
  int get totalCount;
  @override
  bool get incompleteResults;
  @override
  List<Repo> get items;
  @override
  @JsonKey(ignore: true)
  _$$RepoSearchResultImplCopyWith<_$RepoSearchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
