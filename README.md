# yumemi_codecheck_repo_search

株式会社ゆめみ様 Flutter エンジニアコードチェック課題 提出用リポジトリ

動画は[こちら](https://github.com/tyPhoon-collab/yumemi-codecheck-repo-search/pull/56)を参照してください

## 開発環境

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![codecov](https://codecov.io/gh/tyPhoon-collab/yumemi-codecheck-repo-search/graph/badge.svg?token=SnTnvzjge7)](https://codecov.io/gh/tyPhoon-collab/yumemi-codecheck-repo-search)

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

### bashファイル

便利なbashファイルを2つ用意している

- calculate_coverage.sh
  - カバレッジを計算する。UI, Widget, Integrationテストのカバレッジを計算し、lcovファイルをマージする。その際に、カバレッジで考慮するべきでないファイルを除去する
  - lcovコマンドをインストールする必要がある
    - `brew install lcov`
- arb_sort.sh
  - arbファイルをソートする。ローカライズの値を探すときに便利になる
  - 実行すると`arb_utils`がインストールされます

### デプロイ

デプロイ環境は用意していない。ただし、ブランチをmain, devに分けて管理していて、mainブランチはリリース可能なコードがあるとする。そのため、[Codemagic](https://codemagic.io/apps)などでmainのプッシュを監視すれば、プッシュ＋リリースノートの記述のみでリリースできる想定

## アピールする点

<!-- TODO 後でまとめる -->
- レビューのしやすさ
  - issue, pull requestを積極的に使用
- Git
  - mainとdevを分けて運用。devに対してPR
  - PRの使用
  - コミットは極力意味で分けるようにし、コミットメッセージにprefixを付与
    - ex) Update, Fix, Change, Rename, Add...
- 簡潔性・可読性・安全性・保守性の高いコード
  - cSpellによるタイポの制御
- Dart の言語機能を適切に使いこなせているか
  - 新しい機能であるブランチ構文などを使用
- テスト
  - riverpodを用いたDI
    - モックの置き換えが簡単
    - ex) overrideWith, overrideWithValue
  - mocktailの導入
    - 柔軟なモック
    - ex) when(() => MockClass).thenAnswer((_) => value)
  - 高いテストのカバレッジ
- UI/UX
  - Material 3 に則ったデザイン
  - 横画面の対応
- CI/CD
  - GitHub Actions
    - `flutter test`の自動化
    - Codecovとの連携
      - Android emulatorを使用した統合テストも含む
  - very_good_analysisの導入
  - [デプロイ](#デプロイ)の想定

## 開発日記

### 6/15

- 評価ポイントとして「レビューのしやすさ」があるため、チーム開発を意識して、issue作成→PR作成→PRマージという流れを取ることにした。
- GitHub REST API 構築のために、retrofitとfreezedを使用することにした。
  - 良くテストされているはずの既存のREST API Wrapperを使用することで、負担を軽減する。
  - freezedを使用することにより、immutableかつ、便利なモデルクラスを構築する。

- FlutterにはSearchDelegateという機能があるが、挙動を柔軟にカスタマイズしたいかつ、showSearchを呼び出してTextFieldを表示する仕様のため、検索が主体のアプリでは適していないと考え、使用しない。
- 検索バーのデザインはTextFieldをカスタマイズしてもよいが、SearchBarやSearchAnchorが完成されたデザインを提供しているので、こちらを使用する。
- issueやforkなどのアイコンは[こちら](https://primer.style/foundations/icons/)から参照する。
- アニメーションの追加
- ローカライズの実装
- テーマの実装、ダークモードの対応

### 6/16

- 検索クエリの履歴を保存するようにした
  - 最初はSearchAnchorの使用を検討していたが、検索バーがキーボードに追従しなかったり、suggestionsの再描画がされなかったりなど、挙動が不安定であったため使用しない
  - 単純に検索バーの下部にリスト形式で検索クエリの履歴を表示するようにした

- workflowsを追加、PR時にflutter testが走るようにした

- 全体的なリファクタリングを行った
  - ファイル分けなど。適切にファイル分けすることで、AIによるリファクタリング、Widgetテストの作成が捗った
- テストを追加
  - 画面遷移を伴うものはIntegrationテスト、画面遷移を伴わないものはWidgetテスト、サービスクラスなど、UIと関係の無いものはUnitテストという分け方にする。
  - mocktailとmockitoのどちらを採用してもよいが、使用経験があるかつ、いちいちbuildする必要のないmocktailを採用した

### 6/17

- 引き続きテストの実装
- タイトルのデザインを修正
  - 太字に。ローカライズもしたが、日本語では少しダサいので、あえて英語を用いている
- 設定画面を追加
- エラーの修正やリファクタリング

### 6/18

- 改ページ機能の追加
  - ドキュメントを良く読んでいなかった、かつ、知識不足で時間を取られた
  - [ここ](https://docs.github.com/ja/rest/using-the-rest-api/using-pagination-in-the-rest-api?apiVersion=2022-11-28)に詳しく書いてあるが、応答ヘッダーに次のページや最後のページの情報が含まれている。bodyのtotalCountが大きな値であっても、最大のページ数が決まっている
    - ただし、可用性を意識して書いていたため、サービスクラスのシグネチャを変えても、たった三箇所の修正で済んだ
      - 具体的には、サービスクラスをProviderでラップすることによって、クライアントコードの変更は一切なく、プロバイダーの実装を変更する修正で済んだ
      - 同様にテストコードにおいても、意味的に共通な部分は共通化しておいたので、問題なく対応できた

- リファクタリング
  - ファイル分割
  - 冗長な名前を修正
    - 名前の命名規則を決めるべきだった
    - 特にProviderはシンプルな名前のほうが良いと感じた
      - ex) repoSearchResultProvider -> resultProvider
      - 基本的にProviderというsuffixがつくので、名前が衝突しにくい

### 6/19

- テストをカバレッジ97%程度まで実装
- UI/UXの向上
  - 横画面でも問題ないようにUIを改善
  - 特に、ソート手法を選択するUIは、選択肢としてPopupMenuButtonとMenuAnchor、DropdownButtonとDropdownMenuなど、同じ機能をもつWidgetが複数あり、どれを使うべきか悩んだ
  - 結果として、[MenuAnchor](https://api.flutter.dev/flutter/material/MenuAnchor-class.html)を採用した
    - Material 3に対応したWidgetである。[参考](https://api.flutter.dev/flutter/material/PopupMenuButton-class.html)
    - 個人的に、直感的なコードが書ける
    - Dropdownと比べて必要なスペースが少ない
      - 横画面対応の際に有利
      - SearchBarにIconButtonとして配置。配置するボタンは２個まで許されている。[参考](https://m3.material.io/components/search/guidelines)
      - 唯一のデメリットとして、カスタマイズ性が低いことが挙げられる
        - アニメーションの設定などができない
        - サードパーティのパッケージや自前実装を検討しても良いかもしれない

### 6/20

- READMEを更新
- Codecovとの連携をした
  - actというツールをつかってGitHut Actionsをローカルでデバッグしていたが、actでは制限が多く、実態とは違うことが多く時間を取られてしまった
    - runs-onでmacOSが使えない
      - 無料枠の関係で、ubuntuを使用するので、あまり問題ではない
    - Android emulatorで必要なKVMがローカルでは動かなかった
  - アクションを起こしたいブランチに対してPRを出して確認するほうが良い

### 6/21

- デザインを更に改良
  - 横画面対応を進めた
    - [ガイドライン](https://m3.material.io/components/lists/guidelines)より、ListTileを横に並べるのも効果的と気付いたため、修正
- バグ修正
- テストの実装
