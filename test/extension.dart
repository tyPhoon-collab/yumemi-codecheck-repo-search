import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

extension Settle on WidgetTester {
  Future<void> tapAndSettle(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
  }

  Future<void> enterTextAndSettle(Finder finder, String text) async {
    await enterText(finder, text);
    await pumpAndSettle();
  }

  Future<void> submitAndSettle(
    TextInputAction action,
  ) async {
    await testTextInput.receiveAction(action);
    await pumpAndSettle();
  }

  /// WidgetTester.pageBackが失敗することがある。
  /// そこで、オリジナルのページを戻るためのメソッドを追加。
  Future<void> pageBackSafe() {
    return tapAndSettle(_findBackIcon());
  }

  Finder _findBackIcon() {
    var icon = _findInAppBar(find.byType(BackButton));
    if (icon.evaluate().isEmpty) {
      icon = _findInAppBar(find.byType(CloseButton));
    }
    return icon;
  }

  Finder _findInAppBar(Finder finder) {
    return find.descendant(of: find.byType(AppBar), matching: finder);
  }

  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    var wasTimeout = false;
    final timer = Timer(timeout, () => wasTimeout = true);

    while (true) {
      await pumpAndSettle();
      if (wasTimeout || any(finder)) break;
    }
    if (wasTimeout) {
      fail('Pump until found has timed out');
    } else {
      timer.cancel();
    }
  }

  Future<void> pumpUntilNotFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    var wasTimeout = false;
    final timer = Timer(timeout, () => wasTimeout = true);

    while (true) {
      await pumpAndSettle();
      if (wasTimeout || !any(finder)) break;
    }
    if (wasTimeout) {
      fail('Pump until not found has timed out');
    } else {
      timer.cancel();
    }
  }
}

extension Container on WidgetTester {
  ProviderContainer container() {
    return ProviderScope.containerOf(
      element(find.byType(MaterialApp)),
    );
  }

  String? readQuery() {
    return container().read(queryProvider);
  }
}
