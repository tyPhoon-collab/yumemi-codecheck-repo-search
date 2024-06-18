import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

import 'query_provider_test.dart';

Future<void> buildWidget(
  WidgetTester tester,
  Widget Function() builder, {
  int? totalCount,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        totalCountProvider.overrideWithValue(totalCount),
        gitHubRepoServiceProvider.overrideWithValue(MockGitHubRepoService()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [S.delegate],
        home: Scaffold(
          body: builder(),
        ),
      ),
    ),
  );
}

extension Container on WidgetTester {
  ProviderContainer container() {
    return ProviderScope.containerOf(
      element(find.byType(MaterialApp)),
    );
  }
}
