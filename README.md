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

- ページ機能の追加
  - ドキュメントを良く読んでいなかった、かつ、知識不足で時間を取られた
  - [ここ](https://docs.github.com/ja/rest/using-the-rest-api/using-pagination-in-the-rest-api?apiVersion=2022-11-28)に詳しく書いてあるが、応答ヘッダーに次のページや最後のページの情報が含まれている。bodyのtotalCountが大きな値であっても、最大のページ数が決まっている
    - ただし、可用性を意識して書いていたため、サービスクラスのシグネチャを変えても、たった三箇所の修正で済んだ
      - 具体的には、サービスクラスをProviderでラップすることによって、クライアントコードの変更は一切なく、プロバイダーのシグネチャを変更する修正で済んだ
      - 同様にテストコードにおいても、意味的に共通な部分は共通化しておいたので、問題なく対応できた

- リファクタリング
  - ファイル分割
  - 冗長な名前を修正
    - 名前の命名規則を決めるべきだった
    - 特にProviderはシンプルな名前のほうが良いと感じた

### 6/19

- テストをカバレッジ97%程度まで実装
- UI/UXの向上
  - 特に、ソート手法を選択するUIは、選択肢としてPopupMenuButtonとMenuAnchor、DropdownButtonとDropdownMenuなど、同じ機能をもつWidgetが複数あり、どれを使うべきか悩んだ
  - 結果として、MenuAnchorを採用した
    - Material 3に対応したWidgetである。[参考](https://api.flutter.dev/flutter/material/PopupMenuButton-class.html)
    - 個人的に、直感的なコードが書ける
    - Dropdownと比べて必要なスペースが少ない
      - 横画面対応の際に有利
      - SearchBarにIconButtonとして配置。配置するボタンは２個まで許されている。[参考](https://m3.material.io/components/search/guidelines)
      - 唯一のデメリットとして、カスタマイズ性が低いことが挙げられる
        - アニメーションの設定などができない
        - サードパーティのパッケージや自前実装を検討しても良いかもしれない
