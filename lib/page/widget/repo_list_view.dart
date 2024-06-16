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
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

class SearchedRepoListView extends ConsumerWidget {
  const SearchedRepoListView({super.key});

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
                  return RepoListTile(repo: item);
                },
              );
      },
      error: (error, stackTrace) {
        if (error is GitHubRepoServiceException) {
          return ErrorText(text: error.message);
        }

        // 予期しない例外は、どこかにレコードして管理する。今回は省略
        // FirebaseCrashlytics.instance.recordError(error, stackTrace);
        return ErrorText(text: error.toString());
      },
      loading: () => const Center(child: LoadingIndicator()),
    );
  }
}

class RepoListTile extends StatelessWidget {
  const RepoListTile({required this.repo, super.key});

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
