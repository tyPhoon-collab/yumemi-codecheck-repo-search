import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

class PageNumberChangeIconButton extends ConsumerWidget {
  const PageNumberChangeIconButton(this.iconData, this.delta, {super.key});

  const PageNumberChangeIconButton.next({super.key})
      : iconData = Icons.navigate_next,
        delta = 1;

  const PageNumberChangeIconButton.prev({super.key})
      : iconData = Icons.navigate_before,
        delta = -1;

  final IconData iconData;
  final int delta;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(repoSearchPageProvider.notifier).add(delta);
      },
      icon: Icon(iconData),
    );
  }
}
