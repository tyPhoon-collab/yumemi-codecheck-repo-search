import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/sort_type_selection.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

part 'search_query_provider.g.dart';

@riverpod
class RepoSearchQuery extends _$RepoSearchQuery {
  @override
  String? build() {
    return null;
  }

  /// 戻り値は整形後のクエリの文字列とする
  String? update(String value) {
    final query = value.trim();
    if (query.isEmpty) {
      state = null;
      return null;
    }
    state = query;
    ref.read(queryHistoryServiceProvider).add(query);

    return query;
  }

  void reset() => state = null;
}

@riverpod
class RepoSearchSortType extends _$RepoSearchSortType {
  @override
  SortType build() => SortType.bestMatch;

  void update(SortType value) {
    if (value == state) return;

    ref.read(repoSearchPageNumberProvider.notifier).reset();
    state = value;
  }
}

@riverpod
class RepoSearchPageNumber extends _$RepoSearchPageNumber {
  @override
  int build() => 1;

  /// validate()を呼び出してチェックする前提とする
  /// この関数内でチェックしない理由は、不要な引数が増えるため
  void update(int value) {
    if (value == state) return;
    state = value;
  }

  void reset() => state = 1;

  bool validate(int value, int totalCount) {
    final perPage = ref.watch(repoSearchPerPageNumberProvider);
    return value > 0 && (value - 1) * perPage < totalCount;
  }

  int maxPage(int totalCount) {
    final perPage = ref.watch(repoSearchPerPageNumberProvider);
    return (totalCount - 1) ~/ perPage + 1;
  }
}

@riverpod
class RepoSearchPerPageNumber extends _$RepoSearchPerPageNumber {
  @override
  int build() => 30;

  @visibleForTesting
  void update(int value) {
    assert(0 < value && value <= 100, 'invalid value: $value');
    state = value;
  }
}
