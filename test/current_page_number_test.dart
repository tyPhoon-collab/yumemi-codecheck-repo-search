import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/current_page_number.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/page_number_input_dialog.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';

import 'extension.dart';

void main() {
  Future<void> buildWidget(
    WidgetTester tester, {
    int? totalCount,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          totalCountProvider.overrideWithValue(totalCount),
        ],
        child: const MaterialApp(
          localizationsDelegates: [S.delegate],
          home: Scaffold(
            body: CurrentPageNumber(),
          ),
        ),
      ),
    );
  }

  testWidgets('displays LoadingIndicator when totalCount is null',
      (WidgetTester tester) async {
    await buildWidget(tester);

    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  testWidgets('displays correct text when totalCount is not null',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      totalCount: 50,
    );

    expect(find.text(S.current.resultCount(1, 30, 50)), findsOneWidget);

    tester.container().read(pageNumberProvider.notifier).update(2);
    await tester.pump();

    expect(find.text(S.current.resultCount(31, 50, 50)), findsOneWidget);

    tester.container().read(pageNumberProvider.notifier).update(1);
    await tester.pump();

    expect(find.text(S.current.resultCount(1, 30, 50)), findsOneWidget);
  });

  testWidgets('shows page number input dialog on button press',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      totalCount: 50,
    );

    expect(find.text(S.current.resultCount(1, 30, 50)), findsOneWidget);

    await tester.tapAndSettle(find.byType(TextButton));

    expect(find.byType(PageNumberInputDialog), findsOneWidget);
  });

  testWidgets('updates page number when dialog returns a value',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      totalCount: 100,
    );

    await tester.tapAndSettle(find.byType(TextButton));

    await tester.enterText(find.byType(TextFormField), '3');
    await tester.tapAndSettle(find.text('OK'));

    expect(tester.container().read(pageNumberProvider), 3);
    expect(find.text(S.current.resultCount(61, 90, 100)), findsOneWidget);
  });
}
