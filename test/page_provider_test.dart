import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

void main() {
  late ProviderContainer container;
  late RepoSearchPageNumber pageNumber;
  late RepoSearchPerPageNumber perPageNumber;

  setUp(() {
    container = ProviderContainer();
    pageNumber = container.read(repoSearchPageNumberProvider.notifier);
    perPageNumber = container.read(repoSearchPerPageNumberProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is 1', () {
    expect(pageNumber.state, 1);
  });

  test('update method works correctly', () {
    pageNumber.update(10);
    expect(pageNumber.state, 10);
  });

  test('update method with negative value', () {
    pageNumber.update(-10);
    expect(pageNumber.state, -10);
  });

  test('reset method maintains initial state', () {
    pageNumber.reset();
    expect(pageNumber.state, 1);
  });

  test('reset method works correctly', () {
    pageNumber
      ..update(10)
      ..reset();
    expect(pageNumber.state, 1);
  });

  test('validate method works correctly', () {
    perPageNumber.update(10);

    expect(pageNumber.validate(1, 100), isTrue); // 1ページ目、100件
    expect(pageNumber.validate(10, 100), isTrue); // 10ページ目、100件
    expect(pageNumber.validate(11, 100), isFalse); // 11ページ目、100件以上
    expect(pageNumber.validate(0, 100), isFalse); // 0ページ目（無効）
    expect(pageNumber.validate(1, 5), isTrue); // 1ページ目、5件
    expect(pageNumber.validate(2, 5), isFalse); // 2ページ目（無効）、5件
    expect(pageNumber.validate(-1, 100), isFalse); // -1ページ目（無効）
  });
}
