import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/model/owner.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';

import 'custom_test_widgets.dart';
import 'extension.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgetFromSearchPage(
    'search and tap first repo',
    (tester, container) async {
      const query = 'flutter';
      const repo = Repo(
        id: 1,
        createdAt: '',
        name: 'flutter',
        fullName: 'flutter/flutter',
        description: 'Flutter SDK',
        htmlUrl: '',
        stargazersCount: 0,
        watchersCount: 0,
        forksCount: 0,
        openIssuesCount: 0,
        owner: Owner(
          avatarUrl: '',
          htmlUrl: '',
        ),
      );

      when(
        () => container.service.searchRepositories(query),
      ).thenAnswer(
        (_) async => const RepoSearchResult(
          totalCount: 1,
          incompleteResults: false,
          items: [repo],
        ),
      );

      await tester.enterTextAndSettle(find.byType(TextField), 'flutter');
      await tester.submitAndSettle(TextInputAction.search);

      expect(
        find.ancestor(
          of: find.text(query),
          matching: find.byType(TextField),
        ),
        findsOneWidget,
      );
      expect(find.text(repo.fullName), findsOneWidget);
      expect(find.text(repo.description!), findsOneWidget);

      await tester.tapAndSettle(find.byType(ListTile));

      expect(
        find.ancestor(
          of: find.text(repo.name),
          matching: find.byType(AppBar),
        ),
        findsOneWidget,
      );
      expect(find.text(repo.fullName), findsOneWidget);
      expect(find.text(repo.description!), findsOneWidget);
    },
  );
}
