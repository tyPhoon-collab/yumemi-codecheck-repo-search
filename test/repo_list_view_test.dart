import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/error_text.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/repo_list_view.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

import 'mocks.dart';

void main() {
  Future<void> buildWidget(
    WidgetTester tester,
    FutureOr<RepoSearchResult> Function(Ref ref) create,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          resultProvider.overrideWith(create),
        ],
        child: const MaterialApp(
          localizationsDelegates: [S.delegate],
          home: Scaffold(body: SearchedRepoListView()),
        ),
      ),
    );
  }

  testWidgets('shows loading indicator when loading',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      (_) => Future.delayed(
        const Duration(seconds: 1),
        RepoSearchResult.empty,
      ),
    );

    await tester.pump();
    expect(find.byType(LoadingIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(LoadingIndicator), findsNothing);
  });

  testWidgets('shows error text when unexpected', (WidgetTester tester) async {
    await buildWidget(
      tester,
      (_) => Future.error(const UnexpectedGRSException()),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorText), findsOneWidget);
    expect(find.text(S.current.errorUnexpected), findsOneWidget);
  });

  testWidgets('shows error text when no internet', (WidgetTester tester) async {
    await buildWidget(
      tester,
      (_) => Future.error(const NoInternetGRSException()),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorText), findsOneWidget);
    expect(find.text(S.current.errorNoInternet), findsOneWidget);
  });

  testWidgets('shows error text when service unavailable',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      (_) => Future.error(const ServiceUnavailableGRSException()),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorText), findsOneWidget);
    expect(find.text(S.current.errorServiceUnavailable), findsOneWidget);
  });

  testWidgets('shows error text when validation', (WidgetTester tester) async {
    await buildWidget(
      tester,
      (_) => Future.error(const ValidationGRSException()),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorText), findsOneWidget);
    expect(find.text(S.current.errorValidation), findsOneWidget);
  });

  testWidgets('shows error text when truly unexpected',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      (_) => Future.error(const GRSException('Error')),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ErrorText), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('shows list of repos when data is available',
      (WidgetTester tester) async {
    await buildWidget(
      tester,
      (_) => RepoSearchResult.items([generateRepo(), generateRepo()]),
    );

    expect(find.byType(RepoListTile), findsNWidgets(2));
  });
}
