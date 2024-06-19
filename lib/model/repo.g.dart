// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepoImpl _$$RepoImplFromJson(Map<String, dynamic> json) => _$RepoImpl(
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      htmlUrl: json['html_url'] as String,
      stargazersCount: (json['stargazers_count'] as num).toInt(),
      watchersCount: (json['watchers_count'] as num).toInt(),
      forksCount: (json['forks_count'] as num).toInt(),
      openIssuesCount: (json['open_issues_count'] as num).toInt(),
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$$RepoImplToJson(_$RepoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'name': instance.name,
      'full_name': instance.fullName,
      'html_url': instance.htmlUrl,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
      'owner': instance.owner.toJson(),
      'description': instance.description,
      'language': instance.language,
    };
