import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

enum SortType {
  bestMatch('best-match', Icons.sort_by_alpha_outlined),
  stars('stars', Icons.star_outline),
  forks('forks', Icons.fork_right_outlined),
  helpWantedIssues('help-wanted-issues', Icons.help_outline),
  updated('updated', Icons.update_outlined),
  ;

  const SortType(this.query, this.iconData);

  final String query;
  final IconData iconData;

  String get displayName => switch (this) {
        SortType.bestMatch => 'Best Match',
        SortType.stars => 'Stars',
        SortType.forks => 'Forks',
        SortType.helpWantedIssues => 'Help Wanted Issues',
        SortType.updated => 'Updated',
      };
}

class SortTypeSelection extends ConsumerWidget {
  const SortTypeSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButton2(
        value: ref.watch(repoSearchSortTypeProvider),
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
            ref.read(repoSearchSortTypeProvider.notifier).update(value);
          }
        },
      ),
    );
  }

  Iterable<DropdownMenuItem<SortType>> _buildItems(BuildContext context) sync* {
    for (final sortType in SortType.values) {
      yield DropdownMenuItem(
        value: sortType,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(sortType.iconData),
            const SizedBox(width: 8),
            Text(sortType.displayName),
          ],
        ),
      );
    }
  }

  Iterable<Widget> _buildSelectedItems(BuildContext context) sync* {
    for (final sortType in SortType.values) {
      yield Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(sortType.iconData),
          const SizedBox(width: 8),
          DefaultTextStyle.merge(
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
            ),
            child: const Text('Sort by: '),
          ),
          Text(sortType.displayName),
        ],
      );
    }
  }
}
