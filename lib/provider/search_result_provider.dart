import 'dart:io' show SocketException;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

part 'search_result_provider.g.dart';

/// エラー時は必ずGitHubRepoServiceExceptionをthrowする
@riverpod
Future<RepoSearchResult?> result(ResultRef ref) async {
  final service = ref.watch(gitHubRepoServiceProvider);
  final query = ref.watch(queryProvider);
  final sortType = ref.watch(sortTypeProvider);
  final page = ref.watch(pageNumberProvider);
  final perPage = ref.watch(perPageNumberProvider);

  if (query == null) {
    return null;
  }

  try {
    final response = await service.searchRepositories(
      query,
      sort: sortType.query,
      page: page,
      perPage: perPage,
    );

    // 最終ページの更新
    ref.read(lastPageNumberProvider.notifier).setFromResponse(response);

    // 検索履歴に追加
    await ref.read(queryHistoryServiceProvider).add(query);

    // 検索結果を返却
    return response.data;
  } catch (error) {
    throw switch (error) {
      final DioException e => switch (e.response?.statusCode) {
          422 => const ValidationGRSException(),
          503 => const ServiceUnavailableGRSException(),
          _ => const UnexpectedGRSException(),
        },
      final SocketException _ => const NoInternetGRSException(),
      final GRSException e => e,
      _ => GRSException(error.toString()),
    };
  }
}

@Riverpod(keepAlive: true)
class LastPageNumber extends _$LastPageNumber {
  @override
  int? build() => null;

  /// https://docs.github.com/ja/rest/using-the-rest-api/using-pagination-in-the-rest-api?apiVersion=2022-11-28
  /// 改ページのために必要な情報は応答ヘッダーに含まれる。それを抽出する
  void setFromResponse(HttpResponse<RepoSearchResult> response) {
    final linkString = response.response.headers.value('link') ?? '';

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

    final currentPage = ref.read(pageNumberProvider);

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

// RepoSearchResult.totalCountは大きい値でも、全てのページを参照することはできない
// そのため、Headerから算出できる最終ページから全件数を計算し、小さい値をtotalCountとする
@riverpod
int? totalCount(TotalCountRef ref) {
  final lastPage = ref.watch(lastPageNumberProvider);

  if (lastPage == null) return null;

  final int totalCount;
  try {
    totalCount = ref.watch(resultProvider).value?.totalCount ?? 0;
  } catch (error) {
    return null;
  }

  final perPage = ref.watch(perPageNumberProvider);

  return min(perPage * lastPage, totalCount);
}
