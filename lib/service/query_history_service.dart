import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class QueryHistoryService {
  Future<List<String>> getAll();
  Future<void> add(String query);
  Future<void> remove(String query);
  Future<void> clearAll();
}

class PrefsQueryHistoryService implements QueryHistoryService {
  PrefsQueryHistoryService({this.maxQueries = 5});

  static const String _queriesKey = 'cached_queries';

  final int maxQueries;

  Future<SharedPreferences> _getPrefs() async {
    return SharedPreferences.getInstance();
  }

  @override
  Future<List<String>> getAll() async {
    final prefs = await _getPrefs();
    return prefs.getStringList(_queriesKey) ?? [];
  }

  Future<void> _saveQueries(List<String> queries) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(_queriesKey, queries);
  }

  @override
  Future<void> add(String query) async {
    final queries = await getAll();
    if (!queries.contains(query)) {
      if (queries.length >= maxQueries) {
        queries.removeLast(); // 先頭のクエリを削除
      }
      queries.insert(0, query);
      await _saveQueries(queries);
    }
  }

  @override
  Future<void> remove(String query) async {
    final queries = await getAll();
    if (queries.contains(query)) {
      queries.remove(query);
      await _saveQueries(queries);
    }
  }

  @override
  Future<void> clearAll() async {
    final prefs = await _getPrefs();
    await prefs.remove(_queriesKey);
  }
}

class ReactiveQueryHistoryService implements QueryHistoryService {
  ReactiveQueryHistoryService(this.service) {
    _notify();
  }

  final QueryHistoryService service;
  final StreamController<List<String>> _controller =
      StreamController<List<String>>();

  Stream<List<String>> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  @override
  Future<void> add(String query) async {
    await service.add(query);
    await _notify();
  }

  @override
  Future<void> clearAll() async {
    await service.clearAll();
    await _notify();
  }

  @override
  Future<List<String>> getAll() => service.getAll();

  @override
  Future<void> remove(String query) async {
    await service.remove(query);
    await _notify();
  }

  Future<void> _notify() async => _controller.add(await service.getAll());
}
