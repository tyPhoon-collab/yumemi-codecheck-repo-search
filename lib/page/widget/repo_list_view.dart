import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/brightness_adaptive_svg.dart';
import 'package:yumemi_codecheck_repo_search/common/error_text.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/const.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_detail_page.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

class RepoListView extends ConsumerWidget {
  const RepoListView({super.key});

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
      error: (error, stackTrace) =>
          ErrorText(text: error.toString()), // TODO: 適切なエラーメッセージを表示,
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
      leading: const BrightnessAdaptiveSvg(SvgAssets.repo),
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
