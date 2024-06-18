import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

import 'mocks.dart';

class MockGitHubRepoService extends Mock implements GitHubRepoService {}

/// クエリプロバイダーの更新→リザルトプロバイダーの更新の流れを確認する
/// 適切なExceptionが返ってくるかもチェックする
void main() {
  late ProviderContainer container;
  late MockGitHubRepoService mockGitHubRepoService;

  setUp(() async {
    await S.delegate.load(const Locale('en'));
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

  void expectExceptionMessage(
    String message,
  ) {
    expect(
      () => container.read(resultProvider.future),
      throwsA(
        isA<GitHubRepoServiceException>().having(
          (e) => e.message,
          'message',
          message,
        ),
      ),
    );
  }

  void testExceptionMessage(
    Exception exception,
    String message,
  ) {
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      exception: exception,
    );

    container.read(queryProvider.notifier).state = 'flutter';

    expectExceptionMessage(message);
  }

  void testDioExceptionMessage(
    int statusCode,
    String message,
  ) {
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      exception: DioException(
        requestOptions: RequestOptions(),
        response: Response(
          requestOptions: RequestOptions(),
          statusCode: statusCode,
        ),
      ),
    );

    container.read(queryProvider.notifier).state = 'flutter';

    expectExceptionMessage(message);
  }

  test('returns null when query is null', () async {
    container.read(queryProvider.notifier).state = null;

    final result = await container.read(resultProvider.future);

    expect(result, isNull);
  });

  test('returns search result when searchRepositories succeeds', () async {
    final expectedResult = RepoSearchResult.items([Repo.mock()]);
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      result: expectedResult,
    );

    const query = 'flutter';
    container.read(queryProvider.notifier).state = query;

    final result = await container.read(resultProvider.future);

    expect(result, equals(expectedResult));
  });

  test('throws with correct message for 422 error', () async {
    testDioExceptionMessage(422, S.current.errorValidation);
  });

  test('throws with correct message for 503 error', () async {
    testDioExceptionMessage(503, S.current.errorServiceUnavailable);
  });

  test('throws with correct message for unexpected DioException', () async {
    testDioExceptionMessage(500, S.current.errorUnexpected);
  });

  test('throws with correct message for SocketException', () async {
    testExceptionMessage(
      const SocketException('No Internet'),
      S.current.errorNoInternet,
    );
  });

  test('throws with correct message for unexpected error', () async {
    testExceptionMessage(
      Exception('Unknown error'),
      S.current.errorUnexpected,
    );
  });
}
