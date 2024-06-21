import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/const.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/settings_page.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/change_page_number_icon_button.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/current_page_number.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/repo_list_view.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/search_bar.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/suggestion_view.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';

class GitHubRepoSearchPage extends ConsumerStatefulWidget {
  const GitHubRepoSearchPage({super.key});

  @override
  ConsumerState<GitHubRepoSearchPage> createState() =>
      _GitHubRepoSearchPageState();
}

class _GitHubRepoSearchPageState extends ConsumerState<GitHubRepoSearchPage> {
  // 横画面では縦のスペースが少ないので、必要なときのみページ遷移ツールや現在のページを表示する
  // それを管理する変数
  bool _showCurrentPageNumber = true;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final hasQuery = ref.watch(hasQueryProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          // 画面幅によってpaddingを変える
          // FABでUIが隠れてしまうのを防いでいる
          // 特に検索前（!hasQuery）はFABによって履歴のゴミ箱ボタンが押せなくなるので、余計に余白を入れる
          padding: EdgeInsets.symmetric(
            horizontal: !isPortrait && !hasQuery ? 64 : 16,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _TitleWidget(),
                const RepoSearchBar(),
                const SizedBox(height: 8),
                Flexible(
                  child: AnimatedSize(
                    duration: Animations.searched.duration,
                    curve: Animations.searched.curve,
                    child: hasQuery
                        ? NotificationListener<ScrollNotification>(
                            onNotification: _onScrollNotification,
                            child: SearchedRepoListView(
                              padding: EdgeInsets.only(
                                top: 4,
                                bottom: isPortrait ? 4 : 68,
                              ),
                            ),
                          )
                        : const SuggestionsView(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: _pushToSettings,
        child: const Icon(Icons.settings),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: hasQuery && _showCurrentPageNumber
          ? [
              ChangePageNumberIconButton.first(),
              ChangePageNumberIconButton.prev(),
              const CurrentPageNumber(),
              ChangePageNumberIconButton.next(),
              ChangePageNumberIconButton.last(
                ref.watch(lastPageNumberProvider) ?? 0,
              ),
            ]
          : null,
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    final showCurrentPageNumber = notification.metrics.atEdge ||
        MediaQuery.orientationOf(context) == Orientation.portrait;

    if (_showCurrentPageNumber != showCurrentPageNumber) {
      setState(() {
        _showCurrentPageNumber = showCurrentPageNumber;
      });
    }
    return true;
  }

  void _pushToSettings() {
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
        fullscreenDialog: true,
      ),
    );
  }
}

class _TitleWidget extends ConsumerWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final hasQuery = ref.watch(hasQueryProvider);

    return Padding(
      padding: EdgeInsets.all(hasQuery ? 4 : 16),
      child: AnimatedDefaultTextStyle(
        style: (hasQuery ? textTheme.titleMedium! : textTheme.headlineMedium!)
            .copyWith(fontWeight: FontWeight.bold),
        duration: Animations.searched.duration,
        curve: Animations.searched.curve,
        child: Text(S.current.title),
      ),
    );
  }
}
