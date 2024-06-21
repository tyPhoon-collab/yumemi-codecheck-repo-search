import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/sort_type.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

export 'package:yumemi_codecheck_repo_search/common/sort_type.dart';

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
