import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/main.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_search_page.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

import '../test/mocks.dart';
import 'extension.dart';

typedef WidgetTesterCallbackWithService = Future<void> Function(
  WidgetTester tester,
  ProviderContainer container,
);

@isTest
Future<void> testWidgetFromSearchPage(
  String description,
  WidgetTesterCallbackWithService callback, {
  List<String>? history,
}) async {
  final searchService = MockGtHubRepoService();
  final queryHistoryService = MockQueryHistoryService();

  when(
    () => searchService.searchRepositories(any()),
  ).thenAnswer(
    (_) async => RepoSearchResult.empty(),
  );

  registerMockQueryHistoryServiceWhens(queryHistoryService, history ?? []);

  final container = ProviderContainer(
    overrides: [
      gitHubRepoServiceProvider.overrideWithValue(searchService),
      queryHistoryServiceImplProvider.overrideWithValue(queryHistoryService),
    ],
  );

  testWidgets(description, (tester) async {
    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    );

    await tester.pumpUntilFound(find.byType(GitHubRepoSearchPage));

    await callback(
      tester,
      container,
    );

    container.dispose();
  });
}
