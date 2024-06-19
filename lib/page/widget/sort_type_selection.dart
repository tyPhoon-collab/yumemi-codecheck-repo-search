import 'package:dropdown_button2/dropdown_button2.dart';
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

class SortTypeSelection extends ConsumerWidget {
  const SortTypeSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton2(
      value: ref.watch(sortTypeProvider),
      isExpanded: true,
      selectedItemBuilder: (context) => _buildSelectedItems(context).toList(),
      items: _buildItems(context).toList(),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      onChanged: (value) {
        if (value != null) {
          ref.read(sortTypeProvider.notifier).update(value);
        }
      },
    );
  }

  Iterable<DropdownMenuItem<RepoSearchSortType>> _buildItems(
    BuildContext context,
  ) sync* {
    for (final sortType in RepoSearchSortType.values) {
      yield DropdownMenuItem(
        value: sortType,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SortTypeSymbolIcon(sortType: sortType),
            const SizedBox(width: 16),
            Text(sortType.displayName),
          ],
        ),
      );
    }
  }

  Iterable<Widget> _buildSelectedItems(BuildContext context) sync* {
    for (final sortType in RepoSearchSortType.values) {
      yield Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SortTypeSymbolIcon(sortType: sortType),
          const SizedBox(width: 16),
          DefaultTextStyle.merge(
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
            ),
            child: Text(S.current.sortBy),
          ),
          Text(sortType.displayName),
        ],
      );
    }
  }
}

class SortTypeSelectionByMenu extends ConsumerWidget {
  const SortTypeSelectionByMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) => _buildItems(context).toList(),
      onSelected: ref.read(sortTypeProvider.notifier).update,
      icon: Icon(ref.watch(sortTypeProvider).iconData),
    );
  }

  Iterable<PopupMenuItem<RepoSearchSortType>> _buildItems(
    BuildContext context,
  ) sync* {
    for (final sortType in RepoSearchSortType.values) {
      yield PopupMenuItem(
        value: sortType,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SortTypeSymbolIcon(sortType: sortType),
            const SizedBox(width: 16),
            Text(sortType.displayName),
          ],
        ),
      );
    }
  }
}

class _SortTypeSymbolIcon extends StatelessWidget {
  const _SortTypeSymbolIcon({required this.sortType});

  final RepoSearchSortType sortType;

  @override
  Widget build(BuildContext context) {
    return Icon(
      sortType.iconData,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
