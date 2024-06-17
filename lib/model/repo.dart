import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_codecheck_repo_search/model/owner.dart';

part 'repo.freezed.dart';
part 'repo.g.dart';

@freezed
class Repo with _$Repo {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory Repo({
    required int id,
    required String createdAt,
    required String name,
    required String fullName,
    required String htmlUrl,
    required int stargazersCount,
    required int watchersCount,
    required int forksCount,
    required int openIssuesCount,
    required Owner owner,
    String? description,
    String? language,
  }) = _Repo;

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  factory Repo.mock({
    int? id,
    String? createdAt,
    String? name,
    String? fullName,
    String? htmlUrl,
    int? stargazersCount,
    int? watchersCount,
    int? forksCount,
    int? openIssuesCount,
    Owner? owner,
    String? description,
    String? language,
  }) =>
      Repo(
        id: id ?? 1,
        createdAt: createdAt ?? '2022-01-01T00:00:00.000Z',
        name: name ?? 'repo1',
        fullName: fullName ?? 'repo1/repo1',
        htmlUrl: htmlUrl ?? 'https://github.com/repo1/repo1',
        stargazersCount: stargazersCount ?? 1,
        watchersCount: watchersCount ?? 1,
        forksCount: forksCount ?? 1,
        openIssuesCount: openIssuesCount ?? 1,
        owner: owner ?? const Owner(avatarUrl: '', htmlUrl: ''),
        description: description ?? 'description1',
        language: language ?? 'language1',
      );
}
