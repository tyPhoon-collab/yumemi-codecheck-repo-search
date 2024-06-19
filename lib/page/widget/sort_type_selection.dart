import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

enum RepoSearchSortType {
  bestMatch('best-match', Icons.sort_by_alpha_outlined),
  stars('stars', Icons.star_outline),
  forks('forks', Icons.fork_right_outlined),
  helpWantedIssues('help-wanted-issues', Icons.help_outline),
  updated('updated', Icons.update_outlined),
  ;

  const RepoSearchSortType(this.query, this.iconData);

  final String query;
  final IconData iconData;

  String get displayName => switch (this) {
        RepoSearchSortType.bestMatch => S.current.sortTypeBestMatch,
        RepoSearchSortType.stars => S.current.sortTypeStars,
        RepoSearchSortType.forks => S.current.sortTypeForks,
        RepoSearchSortType.helpWantedIssues =>
          S.current.sortTypeHelpWantedIssues,
        RepoSearchSortType.updated => S.current.sortTypeUpdated,
      };
}

class SortTypeSelection extends ConsumerStatefulWidget {
  const SortTypeSelection({super.key});

  @override
  ConsumerState<SortTypeSelection> createState() => _SortTypeSelectionState();
}

class _SortTypeSelectionState extends ConsumerState<SortTypeSelection> {
  final _controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: _controller,
      menuChildren: [
        for (final sortType in RepoSearchSortType.values)
          MenuItemButton(
            leadingIcon: Icon(sortType.iconData),
            onPressed: () =>
                ref.read(sortTypeProvider.notifier).update(sortType),
            child: Text(sortType.displayName),
          ),
      ],
      child: IconButton(
        onPressed: _controller.open,
        icon: Icon(ref.watch(sortTypeProvider).iconData),
      ),
    );
  }
}
