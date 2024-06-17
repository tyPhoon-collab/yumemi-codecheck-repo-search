import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

void main() {
  late ProviderContainer container;
  late RepoSearchPage repoSearchPage;

  setUp(() {
    container = ProviderContainer();
    repoSearchPage = container.read(repoSearchPageProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is 1', () {
    expect(repoSearchPage.state, 1);
  });

  test('add method works correctly', () {
    repoSearchPage.add(5);
    expect(repoSearchPage.state, 6);
  });

  test('add method with negative value', () {
    repoSearchPage.add(-2);
    expect(repoSearchPage.state, -1);
  });

  test('update method works correctly', () {
    repoSearchPage.update(10);
    expect(repoSearchPage.state, 10);
  });

  test('update method with negative value', () {
    repoSearchPage.update(-10);
    expect(repoSearchPage.state, -10);
  });

  test('reset method maintains initial state', () {
    repoSearchPage.reset();
    expect(repoSearchPage.state, 1);
  });

  test('reset method works correctly', () {
    repoSearchPage
      ..update(10)
      ..reset();
    expect(repoSearchPage.state, 1);
  });

  test('validate method works correctly', () {
    expect(repoSearchPage.validate(1, 100), isTrue); // 1ページ目、100件
    expect(repoSearchPage.validate(10, 100), isTrue); // 10ページ目、100件
    expect(repoSearchPage.validate(11, 100), isFalse); // 11ページ目、100件以上
    expect(repoSearchPage.validate(0, 100), isFalse); // 0ページ目（無効）
    expect(repoSearchPage.validate(1, 5), isTrue); // 1ページ目、5件
    expect(repoSearchPage.validate(2, 5), isFalse); // 2ページ目（無効）、5件
    expect(repoSearchPage.validate(-1, 100), isFalse); // -1ページ目（無効）
  });

  test('validateDelta method works correctly', () {
    repoSearchPage.update(5); // 現在のページを5に設定
    expect(repoSearchPage.validateDelta(1, 100), isTrue); // 6ページ目、100件
    expect(repoSearchPage.validateDelta(5, 100), isTrue); // 10ページ目、100件
    expect(repoSearchPage.validateDelta(6, 100), isFalse); // 11ページ目、100件以上
    expect(repoSearchPage.validateDelta(-4, 100), isTrue); // 1ページ目、100件
    expect(repoSearchPage.validateDelta(-5, 100), isFalse); // 0ページ目（無効）
    expect(repoSearchPage.validateDelta(-10, 100), isFalse); // 負のページ数超過
  });

  test('add method with large value', () {
    repoSearchPage.add(1000000);
    expect(repoSearchPage.state, 1000001);
  });

  test('update method with large value', () {
    repoSearchPage.update(1000000);
    expect(repoSearchPage.state, 1000000);
  });
}