import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/change_page_number_icon_button.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

import '../integration_test/extension.dart';
import 'common.dart';

void main() {
  testWidgets('next button updates the page number',
      (WidgetTester tester) async {
    await buildWidget(tester, ChangePageNumberIconButton.next, totalCount: 100);

    final container = tester.container();

    container.read(pageNumberProvider.notifier).update(1);

    await tester.tapAndSettle(find.byIcon(Icons.navigate_next));

    expect(container.read(pageNumberProvider), 2);
  });

  testWidgets('prev button updates the page number',
      (WidgetTester tester) async {
    await buildWidget(tester, ChangePageNumberIconButton.prev, totalCount: 100);

    final container = tester.container();

    container.read(pageNumberProvider.notifier).update(3);
    await tester.pump();

    await tester.tapAndSettle(find.byIcon(Icons.navigate_before));

    expect(container.read(pageNumberProvider), 2);
  });

  testWidgets('first button updates the page number to 1',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      ChangePageNumberIconButton.first,
      totalCount: 100,
    );

    final container = tester.container();

    container.read(pageNumberProvider.notifier).update(5);
    await tester.pump();

    await tester.tapAndSettle(find.byIcon(Icons.first_page));

    expect(container.read(pageNumberProvider), 1);
  });

  testWidgets('last button updates the page number to last page',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      () => ChangePageNumberIconButton.last(10),
      totalCount: 300,
    );

    final container = tester.container();

    container.read(pageNumberProvider.notifier).update(5);
    await tester.pump();

    await tester.tapAndSettle(find.byIcon(Icons.last_page));

    expect(container.read(pageNumberProvider), 10);
  });

  testWidgets('buttons are disabled when validate returns false',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      () {
        return Column(
          children: [
            ChangePageNumberIconButton.first(),
            ChangePageNumberIconButton.prev(),
            ChangePageNumberIconButton.next(),
            ChangePageNumberIconButton.last(10),
          ],
        );
      },
      totalCount: 300,
    );

    final container = tester.container();

    container.read(pageNumberProvider.notifier).update(1);
    await tester.pump();
    _expectIconButtonEnables(false, false, true, true);

    container.read(pageNumberProvider.notifier).update(2);
    await tester.pump();
    _expectIconButtonEnables(true, true, true, true);

    container.read(pageNumberProvider.notifier).update(10);
    await tester.pump();
    _expectIconButtonEnables(true, true, false, false);
  });

  testWidgets('buttons are all disabled when page number is only one',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      () {
        return Column(
          children: [
            ChangePageNumberIconButton.first(),
            ChangePageNumberIconButton.prev(),
            ChangePageNumberIconButton.next(),
            ChangePageNumberIconButton.last(1),
          ],
        );
      },
      totalCount: 1,
    );

    _expectIconButtonEnables(false, false, false, false);
  });
}

void _expectIconButtonEnables(
  bool first,
  bool prev,
  bool next,
  bool last,
) {
  Matcher mapBoolToNullOrNotNull({required bool enable}) =>
      enable ? isNotNull : isNull;

  IconButton getIconButton(IconData icon) => find
      .ancestor(
        of: find.byIcon(icon),
        matching: find.byType(IconButton),
      )
      .evaluate()
      .first
      .widget as IconButton;

  expect(
    getIconButton(Icons.first_page).onPressed,
    mapBoolToNullOrNotNull(enable: first),
  );

  expect(
    getIconButton(Icons.navigate_before).onPressed,
    mapBoolToNullOrNotNull(enable: prev),
  );

  expect(
    getIconButton(Icons.navigate_next).onPressed,
    mapBoolToNullOrNotNull(enable: next),
  );

  expect(
    getIconButton(Icons.last_page).onPressed,
    mapBoolToNullOrNotNull(enable: last),
  );
}
