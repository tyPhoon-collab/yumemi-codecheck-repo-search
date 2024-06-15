import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

part 'service.g.dart';

@Riverpod(keepAlive: true)
GitHubRepoService gitHubRepoService(GitHubRepoServiceRef ref) {
  final dio = Dio(
    BaseOptions(
      headers: {
        'accept': 'application/vnd.github+json',
      },
    ),
  );

  return GitHubRepoService(dio);
}

@riverpod
Future<RepoSearchResult?> repoSearchResult(RepoSearchResultRef ref) {
  final service = ref.watch(gitHubRepoServiceProvider);
  final query = ref.watch(repoSearchQueryProvider);

  if (query == null) {
    return Future.value();
  }

  return service.searchRepositories(query);
}

@riverpod
class RepoSearchQuery extends _$RepoSearchQuery {
  @override
  String? build() {
    return null;
  }

  // ignore: use_setters_to_change_properties
  void update(String value) {
    state = value;
  }

  // void reset() {}
}
