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
    required String updatedAt,
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

  const Repo._();

  DateTime get createdDateTime => DateTime.parse(createdAt);

  DateTime get updatedDateTime => DateTime.parse(updatedAt);
}
