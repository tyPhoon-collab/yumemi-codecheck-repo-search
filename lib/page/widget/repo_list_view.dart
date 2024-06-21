import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/brightness_adaptive_svg.dart';
import 'package:yumemi_codecheck_repo_search/common/error_text.dart';
import 'package:yumemi_codecheck_repo_search/common/exception/github_repo_service_exception.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/const.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';
import 'package:yumemi_codecheck_repo_search/page/github_repo_detail_page.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';

class SearchedRepoListView extends ConsumerWidget {
  const SearchedRepoListView({
    super.key,
    this.padding,
  });

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(resultProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return result.when(
      data: (data) {
        if (data == null) return const SizedBox();

        final items = data.items;

        if (items.isEmpty) return Center(child: Text(S.current.noResults));

        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return switch (orientation) {
              Orientation.portrait => RepoListView(
                  items: items,
                  padding: padding,
                ),
              Orientation.landscape => RepoGridView(
                  items: items,
                  padding: padding,
                ),
            };
          },
        );
      },
      error: (error, stackTrace) {
        final errorMessage =
            error is GRSException ? error.message : S.current.errorUnexpected;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 64),
            ErrorText(text: errorMessage),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: ref.read(queryProvider.notifier).reset,
              label: Text(S.current.reset),
              icon: const Icon(Icons.refresh),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.errorContainer,
                foregroundColor: colorScheme.onErrorContainer,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: LoadingIndicator()),
    );
  }
}

class RepoListView extends StatelessWidget {
  const RepoListView({required this.items, this.padding, super.key});

  final List<Repo> items;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: padding,
      itemBuilder: (context, index) {
        final item = items[index];
        return RepoListTile(repo: item);
      },
    );
  }
}

class RepoGridView extends StatelessWidget {
  const RepoGridView({required this.items, this.padding, super.key});

  final List<Repo> items;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 3,
      ),
      itemCount: items.length,
      padding: padding,
      itemBuilder: (context, index) {
        final item = items[index];
        return RepoListTile(
          repo: item,
          titleAlignment: ListTileTitleAlignment.titleHeight,
        );
      },
    );
  }
}

class RepoListTile extends StatelessWidget {
  const RepoListTile({
    required this.repo,
    this.titleAlignment = ListTileTitleAlignment.center,
    super.key,
  });

  final Repo repo;
  final ListTileTitleAlignment titleAlignment;

  @override
  Widget build(BuildContext context) {
    final description = repo.description;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(repo.fullName),
        leading: const AdaptiveBrightnessSvg(SvgAssets.repo),
        subtitle: description != null && description.isNotEmpty
            ? Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        onTap: () => _pushToDetail(context),
        titleAlignment: titleAlignment,
      ),
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
