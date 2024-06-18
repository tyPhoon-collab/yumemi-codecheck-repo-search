// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ja';

  static String m0(url) => "${url} が開けませんでした";

  static String m1(total) => "ページ: 1～${total}";

  static String m2(lower, upper, total) => "${total} 件中 ${lower}〜${upper} 件";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
        "clear": MessageLookupByLibrary.simpleMessage("クリア"),
        "clearHistory": MessageLookupByLibrary.simpleMessage("履歴をクリア"),
        "clearHistoryConfirm":
            MessageLookupByLibrary.simpleMessage("履歴をクリアしますか？"),
        "clearHistorySuccess":
            MessageLookupByLibrary.simpleMessage("履歴をクリアしました"),
        "dark": MessageLookupByLibrary.simpleMessage("ダーク"),
        "description": MessageLookupByLibrary.simpleMessage(
            "このアプリはGitHubのリポジトリ検索APIラッパーです。\n\nyumemi codecheck 用に作成されました。"),
        "errorFetchQueryHistory":
            MessageLookupByLibrary.simpleMessage("履歴の取得に失敗しました"),
        "errorNoInternet":
            MessageLookupByLibrary.simpleMessage("インターネットに接続できません"),
        "errorServiceUnavailable":
            MessageLookupByLibrary.simpleMessage("GitHubサーバが一時的に利用できない状態です"),
        "errorUnexpected":
            MessageLookupByLibrary.simpleMessage("予期しないエラーが発生しました"),
        "errorValidation":
            MessageLookupByLibrary.simpleMessage("検証に失敗しました。またはAPIのレート制限です"),
        "failedLaunch": m0,
        "inputPageNumberDialogHint": m1,
        "inputPageNumberDialogTitle":
            MessageLookupByLibrary.simpleMessage("ページ番号を入力"),
        "language": MessageLookupByLibrary.simpleMessage("言語"),
        "light": MessageLookupByLibrary.simpleMessage("ライト"),
        "noResults": MessageLookupByLibrary.simpleMessage("結果が見つかりませんでした"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "resultCount": m2,
        "searchPlaceholder":
            MessageLookupByLibrary.simpleMessage("Repositoryを検索"),
        "sortBy": MessageLookupByLibrary.simpleMessage("並び替え: "),
        "sortTypeBestMatch": MessageLookupByLibrary.simpleMessage("ベストマッチ"),
        "sortTypeForks": MessageLookupByLibrary.simpleMessage("フォーク"),
        "sortTypeHelpWantedIssues":
            MessageLookupByLibrary.simpleMessage("Help Wanted イシュー"),
        "sortTypeStars": MessageLookupByLibrary.simpleMessage("スター"),
        "sortTypeUpdated": MessageLookupByLibrary.simpleMessage("更新"),
        "system": MessageLookupByLibrary.simpleMessage("システム"),
        "theme": MessageLookupByLibrary.simpleMessage("テーマ"),
        "title": MessageLookupByLibrary.simpleMessage("Github Repos Search"),
        "validationPageNumberIsOutOfRange":
            MessageLookupByLibrary.simpleMessage("ページ番号が範囲外です"),
        "validationPleaseEnterANumber":
            MessageLookupByLibrary.simpleMessage("数字を入力してください"),
        "validationPleaseEnterAValidNumber":
            MessageLookupByLibrary.simpleMessage("有効な数字を入力してください")
      };
}
