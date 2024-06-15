import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_detail_page.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

class GitHubRepoSearchPage extends StatefulWidget {
  const GitHubRepoSearchPage({super.key});

  @override
  State<GitHubRepoSearchPage> createState() => _GitHubRepoSearchPageState();
}

class _GitHubRepoSearchPageState extends State<GitHubRepoSearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LogoWidget(),
                SizedBox(height: 16),
                _SearchBar(),
                SizedBox(height: 16),
                _RepoList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RepoList extends ConsumerWidget {
  const _RepoList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(repoSearchResultProvider);

    return result.when(
      data: (data) {
        if (data == null) return const SizedBox();

        final items = data.items;

        return Expanded(
          child: items.isEmpty
              ? const Center(child: Text('No repositories...'))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.fullName),
                      subtitle: Text(item.description ?? ''),
                      onTap: () => _pushToDetail(context, item),
                    );
                  },
                ),
        );
      },
      error: (error, stackTrace) =>
          Text(error.toString()), // TODO: 適切なエラーメッセージを表示,
      loading: () => const Center(child: LoadingIndicator()),
    );
  }

  void _pushToDetail(BuildContext context, Repo repo) {
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
      onSubmitted: ref.read(repoSearchQueryProvider.notifier).update,
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
