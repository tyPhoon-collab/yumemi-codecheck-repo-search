import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

class MockGitHubRepoService extends Mock implements GitHubRepoService {}

/// クエリプロバイダーの更新→リザルトプロバイダーの更新の流れを確認する
/// 適切なExceptionが返ってくるかもチェックする
void main() {
  late ProviderContainer container;
  late MockGitHubRepoService mockGitHubRepoService;

  setUp(() {
    mockGitHubRepoService = MockGitHubRepoService();
    container = ProviderContainer(
      overrides: [
        gitHubRepoServiceProvider.overrideWithValue(mockGitHubRepoService),
      ],
    );

    registerFallbackValue(Uri());
  });

  tearDown(() {
    container.dispose();
  });

  test('returns null when query is null', () async {
    container.read(repoSearchQueryProvider.notifier).state = null;

    final result = await container.read(repoSearchResultProvider.future);

    expect(result, isNull);
  });

  test('returns search result when searchRepositories succeeds', () async {
    const query = 'flutter';
    final expectedResult = RepoSearchResult.items([Repo.mock()]);
    container.read(repoSearchQueryProvider.notifier).state = query;

    when(() => mockGitHubRepoService.searchRepositories(query))
        .thenAnswer((_) async => expectedResult);

    final result = await container.read(repoSearchResultProvider.future);

    expect(result, equals(expectedResult));
  });

  test('throws GitHubRepoServiceException with correct message for 422 error',
      () async {
    const query = 'flutter';
    container.read(repoSearchQueryProvider.notifier).state = query;

    when(() => mockGitHubRepoService.searchRepositories(query)).thenThrow(
      DioException(
        response: Response(requestOptions: RequestOptions(), statusCode: 422),
        requestOptions: RequestOptions(),
      ),
    );

    expect(
      () => container.read(repoSearchResultProvider.future),
      throwsA(isA<GitHubRepoServiceException>()),
    );
  });

  test('throws GitHubRepoServiceException with correct message for 503 error',
      () async {
    const query = 'flutter';
    container.read(repoSearchQueryProvider.notifier).state = query;

    when(() => mockGitHubRepoService.searchRepositories(query)).thenThrow(
      DioException(
        response: Response(requestOptions: RequestOptions(), statusCode: 503),
        requestOptions: RequestOptions(),
      ),
    );

    expect(
      () => container.read(repoSearchResultProvider.future),
      throwsA(isA<GitHubRepoServiceException>()),
    );
  });

  test(
      'throws GitHubRepoServiceException with correct message for unexpected DioException',
      () async {
    const query = 'flutter';
    container.read(repoSearchQueryProvider.notifier).state = query;

    when(() => mockGitHubRepoService.searchRepositories(query)).thenThrow(
      DioException(
        response: Response(requestOptions: RequestOptions(), statusCode: 500),
        requestOptions: RequestOptions(),
      ),
    );

    expect(
      () => container.read(repoSearchResultProvider.future),
      throwsA(isA<GitHubRepoServiceException>()),
    );
  });

  test(
      'throws GitHubRepoServiceException with correct message for SocketException',
      () async {
    const query = 'flutter';
    container.read(repoSearchQueryProvider.notifier).state = query;

    when(() => mockGitHubRepoService.searchRepositories(query))
        .thenThrow(const SocketException('No internet'));

    expect(
      () => container.read(repoSearchResultProvider.future),
      throwsA(isA<GitHubRepoServiceException>()),
    );
  });

  test(
      'throws GitHubRepoServiceException with correct message for unexpected error',
      () async {
    const query = 'flutter';
    container.read(repoSearchQueryProvider.notifier).state = query;

    when(() => mockGitHubRepoService.searchRepositories(query))
        .thenThrow(Exception('Unknown error'));

    expect(
      () => container.read(repoSearchResultProvider.future),
      throwsA(isA<GitHubRepoServiceException>()),
    );
  });
}
