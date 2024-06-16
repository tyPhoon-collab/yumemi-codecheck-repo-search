import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
                const _LogoWidget(),
                const SizedBox(height: 16),
                const RepoSearchBar(),
                const SizedBox(height: 16),
                Flexible(
                  child: AnimatedSize(
                    duration: Durations.medium2,
                    curve: Curves.easeInOutQuart,
                    child: ref.watch(repoSearchQueryProvider) == null
                        ? const SuggestionsView()
                        : const RepoListView(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();

  @override
  Widget build(BuildContext context) {
    // TODO: ロゴは画像で扱う
    return const Text(
      'GitHub Repository Search',
    );
  }
}
