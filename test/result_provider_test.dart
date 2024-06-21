import 'package:dio/dio.dart' show Headers, RequestOptions, Response;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/retrofit.dart' hide Headers;
import 'package:yumemi_codecheck_repo_search/model/repo_search_result.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_result_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  @isTest
  void testSetFromResponse(
    String description,
    String link,
    int expected, {
    int currentPage = 1,
  }) {
    test(description, () {
      container.read(pageNumberProvider.notifier).update(currentPage);

      final response = HttpResponse<RepoSearchResult>(
        RepoSearchResult.empty(),
        Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          headers: Headers()..add('link', link),
        ),
      );

      container.read(lastPageNumberProvider.notifier).setFromResponse(response);

      expect(container.read(lastPageNumberProvider), expected);
    });
  }

  testSetFromResponse(
    'sets state to last page number from response headers',
    '<https://api.github.com/repositories/1300192/issues?page=2>; rel="prev", '
        '<https://api.github.com/repositories/1300192/issues?page=4>; rel="next", '
        '<https://api.github.com/repositories/1300192/issues?page=515>; rel="last", '
        '<https://api.github.com/repositories/1300192/issues?page=1>; rel="first"',
    515,
  );

  testSetFromResponse(
    'returns current page number when last page is not in response headers',
    '<https://api.github.com/repositories/1300192/issues?page=2>; rel="prev", '
        '<https://api.github.com/repositories/1300192/issues?page=4>; rel="next", '
        '<https://api.github.com/repositories/1300192/issues?page=1>; rel="first"',
    1,
  );

  testSetFromResponse(
    'returns current page number when response headers are empty',
    '',
    1,
  );
}
