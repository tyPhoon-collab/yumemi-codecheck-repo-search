import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

void main() {
  test('real request', () async {
    final service = GitHubRepoService(
      Dio(
        BaseOptions(
          headers: {
            'accept': 'application/vnd.github+json',
          },
        ),
      ),
    );

    final result = await service.searchRepositories('flutter');

    // debugPrint(result.toString());

    expect(result, isNotNull);
    expect(result.items.length, lessThanOrEqualTo(30));
  });
}
