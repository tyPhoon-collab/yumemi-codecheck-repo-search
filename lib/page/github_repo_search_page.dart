import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/brightness_adaptive_svg.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
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
                        ? const SizedBox()
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
            ? const Center(child: Text('No repositories...'))
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

class _SearchBar extends HookConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();

    return SearchBar(
      controller: controller,
      leading: const Icon(Icons.search),
      trailing: [
        if (ref.watch(repoSearchQueryProvider) != null)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              controller.clear();
              ref.read(repoSearchQueryProvider.notifier).reset();
            },
          ),
      ],
      padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 16)),
      textInputAction: TextInputAction.search,
      onSubmitted: (text) {
        final query = ref.read(repoSearchQueryProvider.notifier).update(text);

        if (query != null) {
          controller.text = query;
        } else {
          controller.clear();
        }
      },
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'GitHub Repository Search',
    );
  }
}
