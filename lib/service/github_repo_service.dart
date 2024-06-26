import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';

export 'package:yumemi_codecheck_repo_search/common/exception/github_repo_service_exception.dart';

part 'github_repo_service.g.dart';

@RestApi(baseUrl: 'https://api.github.com/')
abstract class GitHubRepoService {
  factory GitHubRepoService(Dio dio, {String baseUrl}) = _GitHubRepoService;

  @GET('/search/repositories')
  Future<HttpResponse<RepoSearchResult>> searchRepositories(
    @Query('q') String query, {
    @Query('page') int? page,
    @Query('per_page') int? perPage,
    @Query('sort') String? sort,
  });
}

/// エラーをチェックする際に便利なクラス
class ExceptionalGitHubRepoService implements GitHubRepoService {
  const ExceptionalGitHubRepoService(this._exception);

  final Exception _exception;

  @override
  Future<HttpResponse<RepoSearchResult>> searchRepositories(
    String query, {
    int? page,
    int? perPage,
    String? sort,
  }) async {
    throw _exception;
  }
}
