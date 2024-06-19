import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/sort_type_selection.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

import 'extension.dart';

void main() {
  Future<void> buildWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [S.delegate],
          home: Scaffold(
            body: SortTypeSelection(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }

  Future<void> tapSelection(WidgetTester tester) async {
    await tester.tapAndSettle(find.byType(SortTypeSelection));
  }

  testWidgets('displays dropdown with correct items',
      (WidgetTester tester) async {
    await buildWidget(tester);
    await tapSelection(tester);

    for (final sortType in RepoSearchSortType.values) {
      expect(find.text(sortType.displayName), findsWidgets);
    }
  });

  testWidgets('changes selection', (WidgetTester tester) async {
    await buildWidget(tester);

    final container = tester.container();

    final firstSortType = container.read(sortTypeProvider);
    const secondSortType = RepoSearchSortType.updated;

    expect(find.byIcon(firstSortType.iconData), findsOneWidget);
    expect(find.byIcon(secondSortType.iconData), findsNothing);

    await tapSelection(tester);

    await tester.tapAndSettle(find.text(secondSortType.displayName).last);

    expect(find.byIcon(firstSortType.iconData), findsNothing);
    expect(find.byIcon(secondSortType.iconData), findsOneWidget);
    expect(tester.container().read(sortTypeProvider), secondSortType);
  });
}
