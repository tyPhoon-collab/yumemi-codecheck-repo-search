import 'dart:math';

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

  testWidgets('displays dropdown with correct items',
      (WidgetTester tester) async {
    await buildWidget(tester);

    await tester.tapAndSettle(find.text(S.current.sortBy));

    for (final sortType in RepoSearchSortType.values) {
      expect(find.text(sortType.displayName), findsWidgets);
    }
  });

  testWidgets('changes selection', (WidgetTester tester) async {
    await buildWidget(tester);

    final container = tester.container();

    final firstSortType = container.read(sortTypeProvider);
    final secondSortType = RepoSearchSortType.values
        .elementAt(Random().nextInt(RepoSearchSortType.values.length));

    expect(find.text(firstSortType.displayName), findsOneWidget);
    expect(find.text(secondSortType.displayName), findsNothing);

    await tester.tapAndSettle(find.text(S.current.sortBy));
    await tester.tapAndSettle(find.text(secondSortType.displayName).last);

    expect(find.text(firstSortType.displayName), findsNothing);
    expect(find.text(secondSortType.displayName), findsOneWidget);
    expect(tester.container().read(sortTypeProvider), secondSortType);
  });
}
