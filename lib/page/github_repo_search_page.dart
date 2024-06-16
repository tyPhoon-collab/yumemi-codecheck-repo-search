import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/brightness_adaptive_svg.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_detail_page.dart';
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
                const _SearchBar(),
                const SizedBox(height: 16),
                Flexible(
                  child: AnimatedSize(
                    duration: Durations.medium2,
                    curve: Curves.easeInOutQuart,
                    child: ref.watch(repoSearchQueryProvider) == null
                        ? const _SuggestionsView()
                        : const _RepoListView(),
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

class _RepoListView extends ConsumerWidget {
  const _RepoListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(repoSearchResultProvider);

    return result.when(
      data: (data) {
        if (data == null) return const SizedBox();

        final items = data.items;

        return items.isEmpty
            ? Center(child: Text(S.current.noResults))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _RepoListTile(repo: item);
                },
              );
      },
      error: (error, stackTrace) => Text(
        error.toString(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ), // TODO: 適切なエラーメッセージを表示,
      loading: () => const Center(child: LoadingIndicator()),
    );
  }
}

class _RepoListTile extends StatelessWidget {
  const _RepoListTile({required this.repo});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(repo.fullName),
      leading: const BrightnessAdaptiveSvg('assets/image/svg/repo.svg'),
      subtitle: Text(
        repo.description ?? '',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => _pushToDetail(context),
    );
  }

  void _pushToDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => GitHubRepoDetailPage(repo: repo),
      ),
    );
  }
}

class _SearchBar extends ConsumerStatefulWidget {
  const _SearchBar();

  @override
  ConsumerState<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<_SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(repoSearchQueryProvider, (_, query) {
      if (query == null) {
        _controller.clear();
      } else {
        _controller.text = query;
      }
    });

    return SearchBar(
      controller: _controller,
      hintText: S.current.searchPlaceholder,
      leading: const Icon(Icons.search),
      trailing: [
        if (ref.watch(repoSearchQueryProvider) != null)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: ref.read(repoSearchQueryProvider.notifier).reset,
          ),
      ],
      padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 16)),
      textInputAction: TextInputAction.search,
      onSubmitted: ref.read(repoSearchQueryProvider.notifier).update,
    );
  }
}

class _SuggestionsView extends ConsumerWidget {
  const _SuggestionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(queryHistoryStreamProvider).when(
          data: (data) {
            if (data.isEmpty) return const SizedBox();

            return SingleChildScrollView(
              child: Column(
                children: [
                  for (final query in data)
                    ListTile(
                      title: Text(query),
                      leading: const Icon(Icons.history),
                      trailing: GestureDetector(
                        onTap: () =>
                            ref.read(queryHistoryServiceProvider).remove(query),
                        child: const Icon(Icons.delete),
                      ),
                      onTap: () => ref
                          .read(repoSearchQueryProvider.notifier)
                          .update(query),
                    ),
                ],
              ),
            );
          },

          error: (error, stackTrace) => Text(
            error.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ), // TODO: 適切なエラーメッセージを表示,
          loading: () => const SizedBox(),
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
