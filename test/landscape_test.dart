import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_detail_page.dart';

Future<void> main() async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> buildWidget(
    WidgetTester tester,
    Widget Function() builder,
  ) async {
    await binding.setSurfaceSize(const Size(400, 300));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [S.delegate],
          home: Scaffold(
            body: builder(),
          ),
        ),
      ),
    );
  }

  testWidgets('shows landscape details', (WidgetTester tester) async {
    await buildWidget(tester, () {
      return GitHubRepoDetailPage(
        repo: Repo.mock(),
      );
    });

    // 今回は簡単にオーバーフローしない(UI描画時にエラーが出ない)か確かめる
    expect(find.byType(GitHubRepoDetailPage), findsOneWidget);
  });
}
