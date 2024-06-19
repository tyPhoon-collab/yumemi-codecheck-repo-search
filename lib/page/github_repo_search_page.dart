import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/const.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/settings_page.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/change_page_number_icon_button.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/current_page_number.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/repo_list_view.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/search_bar.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/sort_type_selection.dart';
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
  bool _showCurrentPage = true;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _TitleWidget(),
                const RepoSearchBar(),
                if (isPortrait)
                  const SortTypeSelection()
                else
                  const SizedBox(height: 8),
                Flexible(
                  child: AnimatedSize(
                    duration: Animations.searched.duration,
                    curve: Animations.searched.curve,
                    child: ref.watch(hasQueryProvider)
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
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const SettingsPage(),
            fullscreenDialog: true,
          ),
        ),
        child: const Icon(Icons.settings),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: ref.watch(hasQueryProvider) && _showCurrentPage
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
    final metrics = notification.metrics;
    final showCurrentPage = metrics.pixels == metrics.maxScrollExtent ||
        MediaQuery.orientationOf(context) == Orientation.portrait;

    if (_showCurrentPage != showCurrentPage) {
      setState(() {
        _showCurrentPage = showCurrentPage;
      });
    }
    return true;
  }
}

class _TitleWidget extends ConsumerWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedDefaultTextStyle(
        style: (ref.watch(hasQueryProvider)
                ? textTheme.titleMedium!
                : textTheme.headlineMedium!)
            .copyWith(fontWeight: FontWeight.bold),
        duration: Animations.searched.duration,
        curve: Animations.searched.curve,
        child: Text(S.current.title),
      ),
    );
  }
}
