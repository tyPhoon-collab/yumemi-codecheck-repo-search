import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/common/error_text.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/suggestion_view.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

import 'mocks.dart';

void main() {
  testWidgets('shows suggestions when data is available',
      (WidgetTester tester) async {
    await _buildWidget(
      tester,
      history: [
        'flutter',
        'dart',
        'hooks',
      ],
    );

    expect(find.byType(ListTile), findsNWidgets(3));
    expect(find.text('flutter'), findsOneWidget);
    expect(find.text('dart'), findsOneWidget);
    expect(find.text('hooks'), findsOneWidget);
  });

  testWidgets('shows no suggestions when data is empty',
      (WidgetTester tester) async {
    await _buildWidget(tester);

    expect(find.byType(SizedBox), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('shows error text when error', (WidgetTester tester) async {
    await _buildWidget(tester, throwError: true);

    expect(find.byType(ErrorText), findsOneWidget);
    expect(find.text('Could not fetch query history'), findsOneWidget);
  });

  testWidgets('removes item on delete icon tap', (WidgetTester tester) async {
    await _buildWidget(tester, history: ['flutter']);

    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('flutter'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.byType(ListTile), findsNothing);
    expect(find.text('flutter'), findsNothing);
  });

  testWidgets('updates suggestions when query is submitted',
      (WidgetTester tester) async {
    await _buildWidget(tester);

    final service =
        ProviderScope.containerOf(tester.element(find.byType(SuggestionsView)))
            .read(queryHistoryServiceProvider);

    await service.add('flutter');

    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text('flutter'), findsOneWidget);
  });
}

Future<void> _buildWidget(
  WidgetTester tester, {
  List<String>? history,
  bool throwError = false,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        queryHistoryServiceImplProvider.overrideWith((_) {
          final service = MockQueryHistoryService();
          if (throwError) {
            when(service.getAll).thenThrow('Error from _buildWidget()');
          } else {
            registerMockQueryHistoryServiceWhens(service, history ?? []);
          }
          return service;
        }),
        gitHubRepoServiceProvider.overrideWithValue(MockGitHubRepoService()),
      ],
      child: const MaterialApp(
        localizationsDelegates: [S.delegate],
        home: Scaffold(
          body: SuggestionsView(),
        ),
      ),
    ),
  );

  await tester.pumpAndSettle();
}
