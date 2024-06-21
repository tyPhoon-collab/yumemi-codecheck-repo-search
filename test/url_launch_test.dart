import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_detail_page.dart';

import 'mocks.dart';

void main() {
  late MockUrlLauncher mock;

  setUp(() {
    mock = MockUrlLauncher();
  });

  Future<void> buildWidget(
    WidgetTester tester, {
    required Repo repo,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [S.delegate],
          home: Scaffold(
            body: GitHubRepoDetailPage(
              repo: repo,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('launch repo url', (WidgetTester tester) async {
    final repo = generateRepo();
    await buildWidget(
      tester,
      repo: repo,
    );

    registerMockUrlLauncherWhen(mock);
    await tester.tap(find.byIcon(Icons.launch));

    verify(() => mock.launchUrl(repo.htmlUrl, any())).called(1);
  });

  testWidgets('launch owner url', (WidgetTester tester) async {
    final repo = generateRepo();
    await buildWidget(
      tester,
      repo: repo,
    );

    registerMockUrlLauncherWhen(mock);
    await tester.tap(find.byKey(const Key('avatar')));

    verify(() => mock.launchUrl(repo.owner.htmlUrl, any())).called(1);
  });

  testWidgets('launch url return false', (WidgetTester tester) async {
    final repo = generateRepo();
    await buildWidget(
      tester,
      repo: repo,
    );

    registerMockUrlLauncherWhen(mock);
    when(() => mock.launchUrl(any(), any())).thenAnswer((_) async => false);

    await tester.tap(find.byIcon(Icons.launch));
    await tester.pump();

    expect(find.text(S.current.failedLaunch(repo.htmlUrl)), findsOneWidget);
  });

  testWidgets('launch url error', (WidgetTester tester) async {
    final repo = generateRepo();
    await buildWidget(
      tester,
      repo: repo,
    );

    registerMockUrlLauncherWhen(mock);
    when(() => mock.launchUrl(any(), any())).thenThrow(Exception());

    await tester.tap(find.byIcon(Icons.launch));
    await tester.pump();

    expect(find.text(S.current.failedLaunch(repo.htmlUrl)), findsOneWidget);
  });
}
