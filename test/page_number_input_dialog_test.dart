import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/page_number_input_dialog.dart';

import 'extension.dart';

void main() {
  int? result;

  setUp(() {
    result = null;
  });

  Future<void> buildWidget(
    WidgetTester tester, {
    int totalCount = 100,
    int maxPage = 5,
    Validate? validate,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [S.delegate],
          home: Scaffold(
            floatingActionButton: Builder(
              builder: (context) {
                return FloatingActionButton(
                  onPressed: () async {
                    result = await showPageNumberInputDialog(
                      context,
                      maxPage,
                      validate ?? (value) => value > 0 && value <= maxPage,
                    );
                  },
                  child: const Icon(Icons.launch),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDialog(WidgetTester tester) async {
    await tester.tapAndSettle(find.byType(FloatingActionButton));
  }

  testWidgets('displays dialog with correct title and hint',
      (WidgetTester tester) async {
    const maxPage = 3;
    await buildWidget(tester, maxPage: maxPage);
    await showDialog(tester);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(S.current.inputPageNumberDialogTitle), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(
      find.text(S.current.inputPageNumberDialogHint(maxPage)),
      findsOneWidget,
    );
  });

  testWidgets('validates empty input', (WidgetTester tester) async {
    await buildWidget(tester);
    await showDialog(tester);

    await tester.tapAndSettle(find.text(S.current.ok));

    expect(find.text(S.current.validationPleaseEnterANumber), findsOneWidget);
  });

  testWidgets('validates non-numeric input', (WidgetTester tester) async {
    await buildWidget(tester);
    await showDialog(tester);

    await tester.enterText(find.byType(TextFormField), 'abc');
    await tester.tapAndSettle(find.text(S.current.ok));

    expect(
      find.text(S.current.validationPleaseEnterAValidNumber),
      findsOneWidget,
    );
  });

  testWidgets('validates out of range input', (WidgetTester tester) async {
    await buildWidget(tester);
    await showDialog(tester);

    await tester.enterText(find.byType(TextFormField), '6');
    await tester.tap(find.text(S.current.ok));
    await tester.pumpAndSettle();

    expect(
      find.text(S.current.validationPageNumberIsOutOfRange),
      findsOneWidget,
    );
  });

  testWidgets('submits valid page number', (WidgetTester tester) async {
    await buildWidget(tester);
    await showDialog(tester);

    await tester.enterText(find.byType(TextFormField), '3');
    await tester.tapAndSettle(find.text(S.current.ok));

    expect(result, equals(3));
  });

  testWidgets('submits valid page number by go', (WidgetTester tester) async {
    await buildWidget(tester);
    await showDialog(tester);

    await tester.enterText(find.byType(TextFormField), '3');
    await tester.submitAndSettle(TextInputAction.go);

    expect(result, equals(3));
  });

  testWidgets('cancels dialog without submitting', (WidgetTester tester) async {
    await buildWidget(tester);
    await showDialog(tester);

    await tester.tapAndSettle(find.text(S.current.cancel));

    expect(result, isNull);
  });
}
