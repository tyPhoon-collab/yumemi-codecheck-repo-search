import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumemi_codecheck_repo_search/service/query_history_service.dart';

void main() {
  late QueryHistoryService queryHistoryService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    queryHistoryService = QueryHistoryService();
  });

  test('Initial query list is empty', () async {
    final queries = await queryHistoryService.getAll();
    expect(queries, isEmpty);
  });

  test('Add a query', () async {
    await queryHistoryService.add('test query');
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query']);
  });

  test('Add another query', () async {
    await queryHistoryService.add('test query 1');
    await queryHistoryService.add('test query 2');
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query 1', 'test query 2']);
  });

  test('Add a duplicate query', () async {
    await queryHistoryService.add('test query');
    await queryHistoryService.add('test query');
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query']);
  });

  test('Remove a query', () async {
    await queryHistoryService.add('test query 1');
    await queryHistoryService.add('test query 2');
    await queryHistoryService.remove(0);
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query 2']);
  });

  test('Clear all queries', () async {
    await queryHistoryService.add('test query 1');
    await queryHistoryService.add('test query 2');
    await queryHistoryService.clearAll();
    final queries = await queryHistoryService.getAll();
    expect(queries, isEmpty);
  });

  test('Limit queries to 5', () async {
    await queryHistoryService.add('query 1');
    await queryHistoryService.add('query 2');
    await queryHistoryService.add('query 3');
    await queryHistoryService.add('query 4');
    await queryHistoryService.add('query 5');
    await queryHistoryService.add('query 6');

    final queries = await queryHistoryService.getAll();
    expect(queries.length, 5);
    expect(queries, ['query 2', 'query 3', 'query 4', 'query 5', 'query 6']);
  });
}
