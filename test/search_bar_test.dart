import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/search_bar.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

import 'extension.dart';
import 'mocks.dart';

void main() {
  Future<void> buildWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gitHubRepoServiceProvider.overrideWithValue(MockGitHubRepoService()),
        ],
        child: const MaterialApp(
          localizationsDelegates: [S.delegate],
          home: Scaffold(
            body: RepoSearchBar(),
          ),
        ),
      ),
    );
  }

  testWidgets('enter text updates the query provider',
      (WidgetTester tester) async {
    await buildWidget(tester);

    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    final query = tester.readQuery();

    expect(query, 'flutter');
  });

  testWidgets('clear button clears the query provider',
      (WidgetTester tester) async {
    await buildWidget(tester);

    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    final query = tester.readQuery();
    expect(query, isNull);
    expect(find.text('flutter'), findsNothing);
  });
}
