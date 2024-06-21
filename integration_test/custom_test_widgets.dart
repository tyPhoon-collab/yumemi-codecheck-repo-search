import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:yumemi_codecheck_repo_search/main.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_search_page.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

import '../test/extension.dart';
import '../test/mocks.dart';

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
  final searchService = MockGitHubRepoService();
  final queryHistoryService = MockQueryHistoryService();

  registerMockGitHubRepoServiceWhen(searchService);
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
