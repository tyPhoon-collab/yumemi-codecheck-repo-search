import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';

void main() {
  test('real request', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // 実際の呼び出し時の設定はProviderに委譲する
    final service = container.read(gitHubRepoServiceProvider);
    final result = await service.searchRepositories('flutter');

    // debugPrint(result.toString());

    expect(result, isNotNull);
    expect(result.data.items.length, lessThanOrEqualTo(30));
  });

  test('exceptional request', () async {
    const service = ExceptionalGitHubRepoService(
      UnexpectedGRSException(),
    );

    expect(
      () async => service.searchRepositories('flutter'),
      throwsA(const UnexpectedGRSException()),
    );
  });
}
