import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

enum SortType {
  bestMatch('best-match', Icons.sort_by_alpha),
  stars('stars', Icons.star),
  forks('forks', Icons.fork_right),
  helpWantedIssues('help-wanted-issues', Icons.help),
  updated('updated', Icons.update),
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
    return DropdownButton(
      value: ref.watch(sortTypeValueProvider),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      isExpanded: true,
      padding: const EdgeInsets.all(8),
      selectedItemBuilder: (context) {
        return SortType.values
            .map(
              (sortType) => Row(
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
              ),
            )
            .toList();
      },
      items: SortType.values
          .map(
            (sortType) => DropdownMenuItem<SortType>(
              value: sortType,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 8),
                  Icon(sortType.iconData),
                  const SizedBox(width: 8),
                  Text(sortType.displayName),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          ref.read(sortTypeValueProvider.notifier).update(value);
        }
      },
    );
  }
}
