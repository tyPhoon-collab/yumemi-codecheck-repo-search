import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumemi_codecheck_repo_search/service/query_history_service.dart';

void main() {
  late PrefsQueryHistoryService queryHistoryService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    queryHistoryService = PrefsQueryHistoryService();
  });

  test('initial query list is empty', () async {
    final queries = await queryHistoryService.getAll();
    expect(queries, isEmpty);
  });

  test('add a query', () async {
    await queryHistoryService.add('test query');
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query']);
  });

  test('add another query', () async {
    await queryHistoryService.add('test query 1');
    await queryHistoryService.add('test query 2');
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query 2', 'test query 1']);
  });

  test('add a duplicate query', () async {
    await queryHistoryService.add('test query');
    await queryHistoryService.add('test query');
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query']);
  });

  test('remove a query', () async {
    await queryHistoryService.add('test query 1');
    await queryHistoryService.add('test query 2');
    await queryHistoryService.remove('test query 1');
    final queries = await queryHistoryService.getAll();
    expect(queries, ['test query 2']);
  });

  test('clear all queries', () async {
    await queryHistoryService.add('test query 1');
    await queryHistoryService.add('test query 2');
    await queryHistoryService.clearAll();
    final queries = await queryHistoryService.getAll();
    expect(queries, isEmpty);
  });

  test('limit queries to 5', () async {
    await queryHistoryService.add('query 1');
    await queryHistoryService.add('query 2');
    await queryHistoryService.add('query 3');
    await queryHistoryService.add('query 4');
    await queryHistoryService.add('query 5');
    await queryHistoryService.add('query 6');

    final queries = await queryHistoryService.getAll();
    expect(queries.length, 5);
    expect(queries, ['query 6', 'query 5', 'query 4', 'query 3', 'query 2']);
  });
}
