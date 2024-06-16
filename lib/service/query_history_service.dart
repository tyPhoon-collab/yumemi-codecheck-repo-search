import 'package:shared_preferences/shared_preferences.dart';

class QueryHistoryService {
  QueryHistoryService({this.maxQueries = 5});

  static const String _queriesKey = 'cached_queries';

  final int maxQueries;

  Future<SharedPreferences> _getPrefs() async {
    return SharedPreferences.getInstance();
  }

  Future<List<String>> getAll() async {
    final prefs = await _getPrefs();
    return prefs.getStringList(_queriesKey) ?? [];
  }

  Future<void> _saveQueries(List<String> queries) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(_queriesKey, queries);
  }

  Future<void> add(String query) async {
    final queries = await getAll();
    if (!queries.contains(query)) {
      if (queries.length >= maxQueries) {
        queries.removeAt(0); // 先頭のクエリを削除
      }
      queries.add(query);
      await _saveQueries(queries);
    }
  }

  Future<void> remove(String query) async {
    final queries = await getAll();
    if (queries.contains(query)) {
      queries.remove(query);
      await _saveQueries(queries);
    }
  }

  Future<void> clearAll() async {
    final prefs = await _getPrefs();
    await prefs.remove(_queriesKey);
  }
}
