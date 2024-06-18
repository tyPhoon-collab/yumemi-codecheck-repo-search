import 'dart:io' show SocketException;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

part 'search_result_provider.g.dart';

/// エラー時は必ずGitHubRepoServiceExceptionをthrowする
/// Sが初期化されている必要があり、やや責務が大きいが、一旦おいておく
@riverpod
Future<RepoSearchResult?> repoSearchResult(RepoSearchResultRef ref) async {
  final service = ref.watch(gitHubRepoServiceProvider);
  final query = ref.watch(repoSearchQueryProvider);
  final sortType = ref.watch(repoSearchSortTypeProvider);
  final page = ref.watch(repoSearchPageNumberProvider);
  final perPage = ref.watch(repoSearchPerPageNumberProvider);

  if (query == null) {
    return Future.value();
  }

  try {
    final response = await service.searchRepositories(
      query,
      sort: sortType.query,
      page: page,
      perPage: perPage,
    );

    ref
        .read(repoSearchLastPageNumberProvider.notifier)
        .setFromResponse(response);
    return response.data;
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
class RepoSearchLastPageNumber extends _$RepoSearchLastPageNumber {
  @override
  int? build() => null;

  /// https://docs.github.com/ja/rest/using-the-rest-api/using-pagination-in-the-rest-api?apiVersion=2022-11-28
  /// 改ページのために必要な情報は応答ヘッダーに含まれる。それを抽出し、モデルに落とし込む
  void setFromResponse(HttpResponse<RepoSearchResult> response) {
    final linkString = response.response.headers.map['link']?.first ?? '';

    final lastPage = _getLastPage(linkString);
    state = lastPage;
  }

  int _getLastPage(String linkHeader) {
    // サンプル
    // https://api.github.com/repositories/1300192/issues?page=2; rel="prev",
    // https://api.github.com/repositories/1300192/issues?page=4; rel="next",
    // https://api.github.com/repositories/1300192/issues?page=515; rel="last",
    // https://api.github.com/repositories/1300192/issues?page=1; rel="first"
    // 実際はサブセットになる。つまり、今回欲しいlastは無いときもある
    // 例としては、現状が最後のページの時。
    // そのときは、ページプロバイダーの値を使用する

    final currentPage = ref.read(repoSearchPageNumberProvider);

    // , で分割してリンクとrelを取得
    final links = linkHeader.split(', ');

    for (final link in links) {
      if (link.contains('rel="last"')) {
        // URLを抽出
        final start = link.indexOf('<') + 1;
        final end = link.indexOf('>');
        final url = link.substring(start, end);

        // pageの値を抽出
        final uri = Uri.parse(url);
        final page = uri.queryParameters['page'];
        return page != null ? int.parse(page) : currentPage;
      }
    }

    return currentPage;
  }
}

@riverpod
int? repoSearchTotalCount(RepoSearchTotalCountRef ref) {
  final lastPage = ref.watch(repoSearchLastPageNumberProvider);
  final totalCount = ref.watch(repoSearchResultProvider).value?.totalCount;
  final perPage = ref.watch(repoSearchPerPageNumberProvider);

  if (lastPage == null || totalCount == null) {
    return null;
  }

  return min(perPage * lastPage, totalCount);
}
