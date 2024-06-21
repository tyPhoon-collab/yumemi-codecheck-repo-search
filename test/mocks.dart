import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:retrofit/retrofit.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:yumemi_codecheck_repo_search/model/owner.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';
import 'package:yumemi_codecheck_repo_search/service/query_history_service.dart';

class MockGitHubRepoService extends Mock implements GitHubRepoService {}

class MockQueryHistoryService extends Mock implements QueryHistoryService {}

// https://stackoverflow.com/questions/72026825/how-to-mock-url-launcher-package-for-flutter-test
class MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

/// Prefsを使わず、メモリ上で履歴を管理する。後片付けがいらない上、書き込みしないので速い
void registerMockQueryHistoryServiceWhens(
  QueryHistoryService mock,
  List<String> history,
) {
  when(mock.getAll).thenAnswer((_) async => history);
  when(() => mock.add(any())).thenAnswer((inv) async {
    history.add(inv.positionalArguments[0] as String);
  });
  when(() => mock.remove(any())).thenAnswer((inv) async {
    history.remove(inv.positionalArguments[0] as String);
  });
  when(mock.clearAll).thenAnswer((_) async {
    history.clear();
  });
}

void registerMockGitHubRepoServiceWhen(
  GitHubRepoService mock, {
  RepoSearchResult? result,
  Exception? exception,
}) {
  final whenObj = when(
    () => mock.searchRepositories(
      any(),
      sort: any(named: 'sort'),
      page: any(named: 'page'),
      perPage: any(named: 'perPage'),
    ),
  );

  if (exception != null) {
    whenObj.thenThrow(exception);
  } else {
    whenObj.thenAnswer(
      (_) async => HttpResponse(
        result ?? RepoSearchResult.empty(),
        Response(requestOptions: RequestOptions(), statusCode: 200),
      ),
    );
  }
}

void registerMockUrlLauncherWhen(MockUrlLauncher mock) {
  registerFallbackValue(const LaunchOptions());
  UrlLauncherPlatform.instance = mock;
  when(() => mock.launchUrl(any(), any())).thenAnswer((_) async => true);
}

Repo generateRepo({
  int? id,
  String? createdAt,
  String? updatedAt,
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
      id: id ?? faker.randomGenerator.integer(100000),
      createdAt: createdAt ?? faker.date.dateTime().toIso8601String(),
      updatedAt: updatedAt ?? faker.date.dateTime().toIso8601String(),
      name: name ?? faker.lorem.word(),
      fullName: fullName ?? '${faker.lorem.word()}/${faker.lorem.word()}',
      htmlUrl: htmlUrl ?? faker.internet.httpUrl(),
      stargazersCount: stargazersCount ?? faker.randomGenerator.integer(10000),
      watchersCount: watchersCount ?? faker.randomGenerator.integer(10000),
      forksCount: forksCount ?? faker.randomGenerator.integer(10000),
      openIssuesCount: openIssuesCount ?? faker.randomGenerator.integer(1000),
      owner: owner ?? generateOwner(),
      description: description ?? faker.lorem.sentence(),
      language: language ?? faker.lorem.word(),
    );

Owner generateOwner({
  String? htmlUrl,
}) {
  return Owner(
    avatarUrl: '',
    htmlUrl: htmlUrl ?? faker.internet.httpUrl(),
  );
}
