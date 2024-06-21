import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_detail_page.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_search_page.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/current_page_number.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

import 'extension.dart';
import 'mocks.dart';

Future<void> main() async {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> buildWidget(
    WidgetTester tester,
    Widget Function() builder,
  ) async {
    await binding.setSurfaceSize(const Size(400, 300));

    final mockGitHubRepoService = MockGitHubRepoService();
    final mockQueryHistoryService = MockQueryHistoryService();

    registerMockQueryHistoryServiceWhens(mockQueryHistoryService, []);
    registerMockGitHubRepoServiceWhen(
      mockGitHubRepoService,
      result: RepoSearchResult.items(List.generate(30, (i) => generateRepo())),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          gitHubRepoServiceProvider.overrideWithValue(mockGitHubRepoService),
          queryHistoryServiceImplProvider
              .overrideWithValue(mockQueryHistoryService),
        ],
        child: MaterialApp(
          localizationsDelegates: const [S.delegate],
          home: Scaffold(
            body: builder(),
          ),
        ),
      ),
    );
  }

  testWidgets('shows landscape search', (WidgetTester tester) async {
    await buildWidget(tester, () => const GitHubRepoSearchPage());

    const query = 'flutter';

    await tester.enterTextAndSettle(find.byType(TextField), query);
    await tester.submitAndSettle(TextInputAction.search);

    expect(find.byType(GridView), findsOneWidget);

    final gridViewHeight = tester.getSize(find.byType(GridView)).height;
    const dragDuration = Duration(milliseconds: 500);

    expect(find.byType(CurrentPageNumber), findsOneWidget);

    // 半分程度スクロール
    // ページ番号は見えなくなる
    await tester.timedDrag(
      find.byType(GridView),
      Offset(0, -gridViewHeight / 2),
      dragDuration,
    );
    await tester.pumpAndSettle();
    expect(find.byType(CurrentPageNumber), findsNothing);

    // 一番下までスクロール
    // ページ番号が出現する
    await tester.timedDrag(
      find.byType(GridView),
      const Offset(0, -1000),
      dragDuration,
    );
    await tester.pumpAndSettle();
    expect(find.byType(CurrentPageNumber), findsOneWidget);
  });

  testWidgets('shows landscape details', (WidgetTester tester) async {
    await buildWidget(tester, () {
      return GitHubRepoDetailPage(
        repo: generateRepo(),
      );
    });

    // 今回は簡単にオーバーフローしない(UI描画時にエラーが出ない)か確かめる
    expect(find.byType(GitHubRepoDetailPage), findsOneWidget);
  });
}
