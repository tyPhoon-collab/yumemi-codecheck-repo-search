import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';

part 'github_repo_service.g.dart';

@RestApi(baseUrl: 'https://api.github.com/')
abstract class GitHubRepoService {
  factory GitHubRepoService(Dio dio, {String baseUrl}) = _GitHubRepoService;

  @GET('/search/repositories')
  Future<RepoSearchResult> searchRepositories(
    @Query('q') String query, {
    @Query('page') int? page,
    @Query('per_page') int? perPage,
    @Query('sort') String? sort,
  });
}

class GitHubRepoServiceException implements Exception {
  const GitHubRepoServiceException(this.message, [this.error]);

  final String message;
  final Object? error;
}
