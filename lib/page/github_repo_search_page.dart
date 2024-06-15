import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        if (data == null) {
          return const SizedBox();
        }
        return Expanded(
          child: ListView.builder(
            itemCount: data.items.length,
            itemBuilder: (context, index) {
              final item = data.items[index];
              return ListTile(
                title: Text(item.fullName),
                subtitle: Text(item.description ?? ''),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => GitHubRepoDetailPage(repo: item),
                  ),
                ),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) =>
          Text(error.toString()), // TODO: 適切なエラーメッセージを表示,
      loading: () => const Center(),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchBar(
      leading: const Icon(Icons.search),
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
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
