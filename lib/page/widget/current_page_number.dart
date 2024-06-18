import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/page_number_input_dialog.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';

class CurrentPageNumber extends ConsumerStatefulWidget {
  const CurrentPageNumber({
    super.key,
  });

  @override
  ConsumerState<CurrentPageNumber> createState() => _CurrentPageNumberState();
}

class _CurrentPageNumberState extends ConsumerState<CurrentPageNumber> {
  late final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = ref.watch(totalCountProvider);
    final currentPage = ref.watch(pageNumberProvider);
    final perPage = ref.watch(perPageNumberProvider);

    if (totalCount == null) {
      return const LoadingIndicator();
    }

    int upperCount() {
      return min(currentPage * perPage, totalCount);
    }

    int lowerCount() {
      return (currentPage - 1) * perPage + 1;
    }

    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      child: Text('${lowerCount()} ~ ${upperCount()} of $totalCount'),
      onPressed: () async {
        final notifier = ref.read(pageNumberProvider.notifier);
        final page = await showPageNumberInputDialog(
          context,
          totalCount,
          notifier.maxPage(totalCount),
        );
        if (page != null) notifier.update(page);
      },
    );
  }
}
