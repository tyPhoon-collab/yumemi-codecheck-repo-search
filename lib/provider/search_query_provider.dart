import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_codecheck_repo_search/page/widget/sort_type_selection.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

part 'search_query_provider.g.dart';

@riverpod
class Query extends _$Query {
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
class SortType extends _$SortType {
  @override
  RepoSearchSortType build() => RepoSearchSortType.bestMatch;

  void update(RepoSearchSortType value) {
    if (value == state) return;

    ref.read(pageNumberProvider.notifier).reset();
    state = value;
  }
}

@riverpod
class PageNumber extends _$PageNumber {
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
    return 1 <= value && value <= maxPage(totalCount);
  }

  int maxPage(int totalCount) {
    final perPage = ref.watch(perPageNumberProvider);
    return (totalCount - 1) ~/ perPage + 1;
  }
}

@riverpod
class PerPageNumber extends _$PerPageNumber {
  @override
  int build() => 30;

  @visibleForTesting
  void update(int value) {
    assert(0 < value && value <= 100, 'invalid value: $value');
    state = value;
  }
}

@riverpod
bool hasQuery(HasQueryRef ref) {
  return ref.watch(queryProvider) != null;
}
