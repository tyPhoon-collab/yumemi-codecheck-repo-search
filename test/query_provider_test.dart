import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/common/exception/github_repo_service_exception.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

import 'mocks.dart';

/// クエリプロバイダーの更新→リザルトプロバイダーの更新の流れを確認する
/// 適切なExceptionが返ってくるかもチェックする
void main() {
  late ProviderContainer container;
  late MockGitHubRepoService mockGitHubRepoService;

  setUp(() async {
    mockGitHubRepoService = MockGitHubRepoService();
    final mockQueryHistoryService = MockQueryHistoryService();

    registerMockQueryHistoryServiceWhens(mockQueryHistoryService, []);
    registerMockGitHubRepoServiceWhen(mockGitHubRepoService);

    container = ProviderContainer(
      overrides: [
        gitHubRepoServiceProvider.overrideWithValue(mockGitHubRepoService),
        queryHistoryServiceImplProvider
            .overrideWithValue(mockQueryHistoryService),
      ],
    );

    registerFallbackValue(Uri());
  });

  tearDown(() {
    container.dispose();
  });

  void updateQuery(String query) {
    container.read(queryProvider.notifier).update(query);
  }

  void testExceptionMessage<T extends Exception>(
    Exception exception,
  ) {
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      exception: exception,
    );

    updateQuery('flutter');

    _expectException<T>(container);
  }

  void testDioExceptionMessage<T extends Exception>(
    int statusCode,
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

    updateQuery('flutter');

    _expectException<T>(container);
  }

  test('returns null when query is null', () async {
    container.read(queryProvider.notifier).state = null;

    final result = await container.read(resultProvider.future);

    expect(result, isNull);
  });

  test('returns search result when searchRepositories succeeds', () async {
    final expectedResult = RepoSearchResult.items([generateRepo()]);
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      result: expectedResult,
    );

    const query = 'flutter';

    updateQuery(query);

    final result = await container.read(resultProvider.future);

    expect(result, equals(expectedResult));
  });

  test('returns null when only spaces', () async {
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      result: RepoSearchResult.empty(),
    );
    updateQuery('   ');

    _expectQuery(container, null);
  });

  test('returns null when only whole spaces', () async {
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      result: RepoSearchResult.empty(),
    );
    updateQuery('　　');

    _expectQuery(container, null);
  });

  test('returns trimmed query', () async {
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      result: RepoSearchResult.empty(),
    );
    updateQuery(' flutter ');

    _expectQuery(container, 'flutter');
  });

  test('throws with correct message for 422 error', () async {
    testDioExceptionMessage<ValidationGRSException>(422);
  });

  test('throws with correct message for 503 error', () async {
    testDioExceptionMessage<ServiceUnavailableGRSException>(503);
  });

  test('throws with correct message for unexpected DioException', () async {
    testDioExceptionMessage<UnexpectedGRSException>(500);
  });

  test('throws with correct message for SocketException', () async {
    testExceptionMessage<NoInternetGRSException>(
      const SocketException('No Internet'),
    );
  });

  test('throws with correct message for unexpected error', () async {
    testExceptionMessage<GRSException>(
      Exception('Unknown error'),
    );
  });
}

void _expectException<T extends Exception>(
  ProviderContainer container,
) {
  expect(
    () => container.read(resultProvider.future),
    throwsA(
      isA<T>(),
    ),
  );
}

void _expectQuery(ProviderContainer container, String? query) {
  expect(container.read(queryProvider), equals(query));
}
