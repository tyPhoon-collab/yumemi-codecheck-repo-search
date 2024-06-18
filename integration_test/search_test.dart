import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/suggestion_view.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

import '../test/extension.dart';
import '../test/mocks.dart';
import 'custom_test_widgets.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgetFromSearchPage(
    'search and tap first repo',
    (tester, container) async {
      const query = 'flutter';
      final repo = Repo.mock(
        name: 'flutter',
        fullName: 'flutter/flutter',
        description: 'Flutter SDK',
      );
      registerMockGitHubRepoServiceWhen(
        container.read(gitHubRepoServiceProvider),
        result: RepoSearchResult.items([repo]),
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

      await tester.pageBackSafe();
      await tester.tapAndSettle(find.byIcon(Icons.close));
      expect(
        find.ancestor(
          of: find.text(query),
          matching: find.byType(SuggestionsView),
        ),
        findsOneWidget,
      );
    },
  );

  testWidgetFromSearchPage(
    'search from suggestion',
    (tester, container) async {
      const query = 'flutter';
      final repo = Repo.mock(
        name: 'flutter',
        fullName: 'flutter/flutter',
        description: 'Flutter SDK',
      );

      registerMockGitHubRepoServiceWhen(
        container.read(gitHubRepoServiceProvider),
        result: RepoSearchResult.items([repo]),
      );

      await tester.pumpAndSettle();
      await tester.tapAndSettle(find.text(query));
      await tester.pumpAndSettle();
      expect(find.text(repo.fullName), findsOneWidget);
      expect(find.text(repo.description!), findsOneWidget);
    },
    history: ['flutter'],
  );
}
