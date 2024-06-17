import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

class ChangePageNumberIconButton extends ConsumerWidget {
  const ChangePageNumberIconButton(this.iconData, this.modifier, {super.key});

  factory ChangePageNumberIconButton.next() {
    return ChangePageNumberIconButton(
      Icons.navigate_next,
      (current, totalCount) => current + 1,
    );
  }

  factory ChangePageNumberIconButton.prev() {
    return ChangePageNumberIconButton(
      Icons.navigate_before,
      (current, totalCount) => current - 1,
    );
  }

  factory ChangePageNumberIconButton.first() {
    return ChangePageNumberIconButton(
      Icons.first_page,
      (current, totalCount) => 1,
    );
  }

  factory ChangePageNumberIconButton.last(int lastPage) {
    return ChangePageNumberIconButton(
      Icons.last_page,
      (current, totalCount) => lastPage,
    );
  }

  final IconData iconData;
  final int Function(int current, int totalCount) modifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCount = ref.watch(realTotalCountProvider) ?? 0;
    final current = ref.watch(repoSearchPageProvider); // ページの変更を監視する
    final notifier = ref.watch(repoSearchPageProvider.notifier);

    return IconButton(
      onPressed: isAvailable(notifier, current, totalCount)
          ? () => notifier.update(getNextPageNumber(current, totalCount))
          : null,
      icon: Icon(iconData),
    );
  }

  bool isAvailable(RepoSearchPage notifier, int current, int totalCount) {
    final next = getNextPageNumber(current, totalCount);
    if (next == current) return false;
    return notifier.validate(next, totalCount);
  }

  int getNextPageNumber(int current, int totalCount) {
    return modifier(current, totalCount);
  }
}
