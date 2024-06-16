import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/main.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_search_page.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

import '../test/mocks.dart';
import 'extension.dart';

typedef WidgetTesterCallbackWithService = Future<void> Function(
  WidgetTester tester,
  ServiceContainer repo,
);

class ServiceContainer {
  ServiceContainer({required this.service}) {
    when(() => service.searchRepositories(any(), page: any(named: 'page')))
        .thenAnswer(
      (_) async => RepoSearchResult.empty(),
    );
  }
  final GitHubRepoService service;
}

@isTest
Future<void> testWidgetFromSearchPage(
  String description,
  WidgetTesterCallbackWithService callback,
) async {
  final service = MockGtHubRepoService();

  testWidgets(description, (tester) async {
    runApp(
      ProviderScope(
        overrides: [
          gitHubRepoServiceProvider.overrideWithValue(service),
        ],
        child: const MyApp(),
      ),
    );

    await tester.pumpUntilFound(find.byType(GitHubRepoSearchPage));

    final container = ServiceContainer(service: service);

    await callback(
      tester,
      container,
    );
  });
}
