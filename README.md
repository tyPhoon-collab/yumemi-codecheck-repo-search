# yumemi_codecheck_repo_search

株式会社ゆめみ様 Flutter エンジニアコードチェック課題 提出用リポジトリ

## 開発環境

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

```bash
$ flutter --version
Flutter 3.22.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 761747bfc5 (9 days ago) • 2024-06-05 22:15:13 +0200
Engine • revision edd8546116
Tools • Dart 3.4.3 • DevTools 2.34.3
```

| 項目   | 詳細         |
| ------ | ------------ |
| PC     | MacBook Pro  |
| チップ | Apple M2 Pro |
| メモリ | 16GB         |
| macOS  | Sonoma 14.5  |

## アピールする点

<!-- TODO 後でまとめる -->

## 開発日記

### 6/15

- 評価ポイントとして「レビューのしやすさ」があるため、チーム開発を意識して、issue作成→PR作成→PRマージという流れを取ることにした。
- GitHub REST API 構築のために、retrofitとfreezedを使用することにした。
  - 良くテストされているはずの既存のREST API Wrapperを使用することで、負担を軽減する。
  - freezedを使用することにより、immutableかつ、便利なモデルクラスを構築する。

- UIは以下のサイトを参考にする
  - <https://sevendex.com/post/11190/>
  - FlutterにはSearchDelegateという機能があるが、挙動を柔軟にカスタマイズしたいかつ、showSearchを呼び出してTextFieldを表示する仕様のため、検索が主体のアプリでは適していないと考え、使用しない。
  - デザインはTextFieldをカスタマイズしてもよいが、SearchBarやSearchAnchorが完成されたデザインを提供しているので、こちらを使用する。
