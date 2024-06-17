import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

class CurrentPageNumber extends ConsumerWidget {
  const CurrentPageNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCount = ref.watch(repoSearchResultProvider).value?.totalCount;
    final currentPage = ref.watch(repoSearchPageProvider);
    final perPage = ref.watch(repoSearchPerPageProvider);

    if (totalCount == null) {
      return const LoadingIndicator();
    }

    int upperCount() {
      return min(currentPage * perPage, totalCount);
    }

    int lowerCount() {
      return (currentPage - 1) * perPage + 1;
    }

    return Text(
      '${lowerCount()} ~ ${upperCount()} of $totalCount',
    );
  }
}
