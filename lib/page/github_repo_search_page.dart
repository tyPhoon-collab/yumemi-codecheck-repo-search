import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/const.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/page/settings_page.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/repo_list_view.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/search_bar.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/suggestion_view.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

class GitHubRepoSearchPage extends ConsumerWidget {
  const GitHubRepoSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Flexible(
                  child: AnimatedSize(
                    duration: Animations.searched.duration,
                    curve: Animations.searched.curve,
                    child: ref.watch(repoSearchQueryProvider) == null
                        ? const SuggestionsView()
                        : const SearchedRepoListView(
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
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
        style: (ref.watch(repoSearchQueryProvider) == null
                ? textTheme.headlineMedium!
                : textTheme.titleMedium!)
            .copyWith(fontWeight: FontWeight.bold),
        duration: Animations.searched.duration,
        curve: Animations.searched.curve,
        child: Text(S.current.title),
      ),
    );
  }
}
