import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';
import 'package:yumemi_codecheck_repo_search/service/query_history_service.dart';

part 'service_provider.g.dart';

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
