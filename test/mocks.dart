import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';
import 'package:yumemi_codecheck_repo_search/service/query_history_service.dart';

class MockGtHubRepoService extends Mock implements GitHubRepoService {}

class MockQueryHistoryService extends Mock implements QueryHistoryService {}

/// Prefsを使わず、メモリ上で履歴を管理する。後片付けがいらない上、書き込みしないので速い
void registerMockQueryHistoryServiceWhens(
  QueryHistoryService mock,
  List<String> history,
) {
  when(mock.getAll).thenAnswer((_) async => history);
  when(() => mock.add(any())).thenAnswer((inv) async {
    history.add(inv.positionalArguments[0] as String);
  });
  when(() => mock.remove(any())).thenAnswer((inv) async {
    history.remove(inv.positionalArguments[0] as String);
  });
  when(mock.clearAll).thenAnswer((_) async {
    history.clear();
  });
}
