# firebase_test

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Firebase Settings

構築>Firestore Database
データベースの作成>テストモードで開始する>作成 ※本番 Devloy では、本番環境モードを利用

### コレクションを作成する

下記を参考にデータ作成

- ドキュメント
  様々な値を保管するもの

- コレクション
  多数のドキュメントをまとめて管理するもの

### PC Settings

npm のインストール

- npm install -g firebase-tools

Firebase へのログイン

- firebase login

Firebase パッケージのインストール

- flutter pub add firebase_core
- flutter pub upgrade firebase_core
- flutter pub get

Firebase のデータベースサービス利用

- flutter pub add cloud_firestore
- flutter pub upgrade cloud_firestore

Flutter プロジェクトに、Firebasen の設定追加

- dart pub global activate flutterfire_cli
- flutterfire configure

### コード内容

下記が参考になりそう

- https://zenn.dev/tukiyubi/articles/9dac6d1779a2b8

### コード生成

flutter pub run build_runner build --delete-conflicting-outputs
