import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
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

@riverpod
Future<RepoSearchResult?> repoSearchResult(RepoSearchResultRef ref) {
  final service = ref.watch(gitHubRepoServiceProvider);
  final query = ref.watch(repoSearchQueryProvider);

  if (query == null) {
    return Future.value();
  }

  try {
    return service.searchRepositories(query);
  } catch (e) {
    final errorMessage = switch (e) {
      final DioException e => switch (e.response?.statusCode) {
          422 => 'Validation failed, or the endpoint has been spammed.',
          503 => 'GitHub service is temporarily unavailable.',
          _ => 'Unexpected error occurred.',
        },
      final SocketException _ => 'No internet connection.',
      _ => 'Unexpected error occurred.',
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
