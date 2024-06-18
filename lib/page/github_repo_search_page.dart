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

class GitHubRepoSearchPage extends ConsumerWidget {
  const GitHubRepoSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 16
                    : 64,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _TitleWidget(),
                const RepoSearchBar(),
                const SortTypeSelection(),
                Flexible(
                  child: AnimatedSize(
                    duration: Animations.searched.duration,
                    curve: Animations.searched.curve,
                    child: ref.watch(hasQueryProvider)
                        ? const SearchedRepoListView(
                            padding: EdgeInsets.only(top: 4, bottom: 32),
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
      persistentFooterButtons: ref.watch(hasQueryProvider)
          ? [
              ChangePageNumberIconButton.first(),
              ChangePageNumberIconButton.prev(),
              const CurrentPageNumber(),
              ChangePageNumberIconButton.next(),
              ChangePageNumberIconButton.last(
                ref.watch(totalCountProvider) ?? 0,
              ),
            ]
          : null,
    );
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
