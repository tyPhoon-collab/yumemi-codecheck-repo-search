import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/common/error_text.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/suggestion_view.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

import 'mocks.dart';

void main() {
  testWidgets('shows suggestions when data is available',
      (WidgetTester tester) async {
    await _buildWidget(
      tester,
      historyBuilder: () => [
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
    await _buildWidget(tester, historyBuilder: () => Future.error('Error'));

    expect(find.byType(ErrorText), findsOneWidget);
    expect(find.text('Could not fetch query history'), findsOneWidget);
  });

  testWidgets('removes item on delete icon tap', (WidgetTester tester) async {
    await _buildWidget(tester, historyBuilder: () => ['flutter']);

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
  FutureOr<List<String>> Function()? historyBuilder,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        queryHistoryServiceImplProvider.overrideWith((_) {
          final service = MockQueryHistoryService();

          final history = historyBuilder?.call() ?? [];
          when(service.getAll).thenAnswer((_) async => history);
          when(() => service.remove(any())).thenAnswer((inv) async {
            if (history is List<String>) {
              history.remove(inv.positionalArguments[0] as String);
            }
          });
          when(service.clearAll).thenAnswer((_) async => []);
          when(() => service.add(any())).thenAnswer((inv) async {
            if (history is List<String>) {
              history.add(inv.positionalArguments[0] as String);
            }
          });
          return service;
        }),
        gitHubRepoServiceProvider.overrideWithValue(MockGtHubRepoService()),
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
