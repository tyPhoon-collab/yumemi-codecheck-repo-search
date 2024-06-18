import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/settings_page.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';
import 'package:yumemi_codecheck_repo_search/theme.dart';

import '../integration_test/extension.dart';
import 'mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    PackageInfo.setMockInitialValues(
      appName: 'mock',
      packageName: 'mock',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '1234',
    );
  });

  testWidgets('shows all settings tiles', (WidgetTester tester) async {
    await _buildWidget(tester);

    expect(find.byKey(const Key('language_list_tile')), findsOneWidget);
    expect(find.byKey(const Key('theme_list_tile')), findsOneWidget);
    expect(
      find.byKey(const Key('clear_all_history_list_tile')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('about_list_tile')), findsOneWidget);
  });

  testWidgets('changes theme on toggle', (WidgetTester tester) async {
    await _buildWidget(tester);

    await tester.tapAndSettle(find.byIcon(Icons.light_mode));
    expect(tester.currentThemeMode, AdaptiveThemeMode.light);

    await tester.tapAndSettle(find.byIcon(Icons.dark_mode));
    expect(tester.currentThemeMode, AdaptiveThemeMode.dark);

    await tester.tapAndSettle(find.byIcon(Icons.brightness_4));
    expect(tester.currentThemeMode, AdaptiveThemeMode.system);
  });

  testWidgets('clear all history list tile is disabled when no history',
      (WidgetTester tester) async {
    await _buildWidget(tester);
    _expectEnable(find.byKey(const Key('clear_all_history_list_tile')), false);
  });

  testWidgets('clear all history', (WidgetTester tester) async {
    await _buildWidget(tester, history: ['1', '2', '3']);

    await tester.pumpAndSettle();

    _expectEnable(find.byKey(const Key('clear_all_history_list_tile')), true);
    await tester
        .tapAndSettle(find.byKey(const Key('clear_all_history_list_tile')));

    expect(find.byType(Dialog), findsOneWidget);

    await tester.tapAndSettle(find.text(S.current.clear));

    expect(find.text(S.current.clearHistorySuccess), findsOneWidget);
    expect(
      await ProviderScope.containerOf(
        tester.element(find.byType(MaterialApp)),
      ).read(queryHistoryServiceProvider).getAll(),
      isEmpty,
    );
  });

  testWidgets('shows about dialog with correct version',
      (WidgetTester tester) async {
    await _buildWidget(tester);

    await tester.tapAndSettle(
      find.byKey(const Key('about_list_tile')),
    );

    expect(find.byType(AboutDialog), findsOneWidget);
    expect(find.text('1.0.0'), findsOneWidget);
    expect(find.text('Copyright 2024 Hiroaki Osawa'), findsOneWidget);
    expect(find.text(S.current.description), findsOneWidget);
  });
}

Future<void> _buildWidget(
  WidgetTester tester, {
  List<String>? history,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        queryHistoryServiceImplProvider.overrideWith((_) {
          final impl = MockQueryHistoryService();
          registerMockQueryHistoryServiceWhens(impl, history ?? []);
          return impl;
        }),
      ],
      child: AdaptiveTheme(
        initial: AdaptiveThemeMode.system,
        light: theme,
        dark: darkTheme,
        builder: (theme, darkTheme) => MaterialApp(
          localizationsDelegates: const [S.delegate],
          theme: theme,
          darkTheme: darkTheme,
          home: const SettingsPage(),
        ),
      ),
    ),
  );
}

extension _GetCurrentThemeMode on WidgetTester {
  AdaptiveThemeMode get currentThemeMode =>
      AdaptiveTheme.of(element(find.byType(MaterialApp))).mode;
}

void _expectEnable(Finder finder, bool enabled) {
  expect(
    (finder.evaluate().first.widget as ListTile).enabled,
    enabled,
  );
}
