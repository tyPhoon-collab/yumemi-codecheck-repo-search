// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepoSearchResultImpl _$$RepoSearchResultImplFromJson(
        Map<String, dynamic> json) =>
    _$RepoSearchResultImpl(
      totalCount: (json['total_count'] as num).toInt(),
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => Repo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RepoSearchResultImplToJson(
        _$RepoSearchResultImpl instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'incomplete_results': instance.incompleteResults,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
