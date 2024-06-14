import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';

part 'repo_search_result.freezed.dart';
part 'repo_search_result.g.dart';

@freezed
class RepoSearchResult with _$RepoSearchResult {
  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  const factory RepoSearchResult({
    required int totalCount,
    required bool incompleteResults,
    required List<Repo> items,
  }) = _RepoSearchResult;

  factory RepoSearchResult.fromJson(Map<String, dynamic> json) =>
      _$RepoSearchResultFromJson(json);
}
