import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/sort_type_selection.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';
import 'package:yumemi_codecheck_repo_search/service/query_history_service.dart';

part 'service.g.dart';

@Riverpod(keepAlive: true)
GitHubRepoService gitHubRepoService(GitHubRepoServiceRef ref) {
  final dio = Dio(
    BaseOptions(
      headers: {
        'accept': 'application/vnd.github+json',
      },
    ),
  );

  return GitHubRepoService(dio);
}

/// エラー時は必ずGitHubRepoServiceExceptionをthrowする
/// Sが初期化されている必要があり、やや責務が大きいが、一旦おいておく
@riverpod
Future<RepoSearchResult?> repoSearchResult(RepoSearchResultRef ref) {
  final service = ref.watch(gitHubRepoServiceProvider);
  final query = ref.watch(repoSearchQueryProvider);
  final sortType = ref.watch(repoSearchSortTypeProvider);
  final page = ref.watch(repoSearchPageProvider);
  final perPage = ref.watch(repoSearchPerPageProvider);

  if (query == null) {
    return Future.value();
  }

  try {
    return service.searchRepositories(
      query,
      sort: sortType.query,
      page: page,
      perPage: perPage,
    );
  } catch (e) {
    final errorMessage = switch (e) {
      final DioException e => switch (e.response?.statusCode) {
          422 => S.current.errorValidation,
          503 => S.current.errorServiceUnavailable,
          _ => S.current.errorUnexpected,
        },
      final SocketException _ => S.current.errorNoInternet,
      _ => S.current.errorUnexpected,
    };

    throw GitHubRepoServiceException(errorMessage, e);
  }
}

@riverpod
class RepoSearchQuery extends _$RepoSearchQuery {
  @override
  String? build() {
    return null;
  }

  /// 戻り値は整形後のクエリの文字列とする
  String? update(String value) {
    final query = value.trim();
    if (query.isEmpty) {
      state = null;
      return null;
    }
    state = query;
    ref.read(queryHistoryServiceProvider).add(query);

    return query;
  }

  void reset() => state = null;
}

@Riverpod(keepAlive: true)
@visibleForTesting
QueryHistoryService queryHistoryServiceImpl(
  QueryHistoryServiceImplRef ref,
) {
  return PrefsQueryHistoryService();
}

@Riverpod(keepAlive: true)
ReactiveQueryHistoryService queryHistoryService(QueryHistoryServiceRef ref) {
  final impl = ref.watch(queryHistoryServiceImplProvider);
  final service = ReactiveQueryHistoryService(impl);
  ref.onDispose(service.dispose);
  return service;
}

@Riverpod(keepAlive: true)
Stream<List<String>> queryHistoryStream(QueryHistoryStreamRef ref) {
  return ref.watch(queryHistoryServiceProvider).stream;
}

@riverpod
class RepoSearchSortType extends _$RepoSearchSortType {
  @override
  SortType build() => SortType.bestMatch;

  void update(SortType value) {
    if (value == state) return;

    ref.read(repoSearchPageProvider.notifier).reset();
    state = value;
  }
}

@riverpod
class RepoSearchPage extends _$RepoSearchPage {
  @override
  int build() => 1;

  /// 呼び出す前は、validate()を呼び出してチェックする前提とする
  /// 本来は、ここでRepoSearchResultのtotalCountを取得するのが良いが
  /// CircularDependencyErrorが発生する
  /// UIの表示の際にvalidate()を呼び出すことが多いので、クライアントコードに責務を移す
  void add(int delta) {
    state = state + delta;
  }

  /// addと同様、呼び出す前は、validate()を呼び出してチェックする前提とする
  void update(int value) {
    if (value == state) return;
    state = value;
  }

  void reset() => state = 1;

  bool validateDelta(int delta, int totalCount) {
    return validate(state + delta, totalCount);
  }

  bool validate(int value, int totalCount) {
    final perPage = ref.watch(repoSearchPerPageProvider);
    return value > 0 && (value - 1) * perPage < totalCount;
  }

  int maxPage(int totalCount) {
    final perPage = ref.watch(repoSearchPerPageProvider);
    return (totalCount - 1) ~/ perPage + 1;
  }
}

@riverpod
class RepoSearchPerPage extends _$RepoSearchPerPage {
  @override
  int build() => 30;
}
