import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_data_storage.dart';

void main() {
  runApp(MyApp());
}

// ChangeNotifierProviderを利用することで、createで作成したインスタンスの状態が変化した際、アプリをビルドし直すことができる
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider：状態の変更を通知する能力を持つオブジェクト
    return ChangeNotifierProvider( // 状態が変更されると、依存する下記のウィジェットに通知が送られる
      // 新しいインスタンスを作成 → ここで作成したインスタンスが、ウィジェットツリーでの状態管理に利用される
      create: (context) => ThemeModeNotifier(),
      // createで作成したインスタンスを検知し、状態が変化した際にビルド関数を実行する
      child: Consumer<ThemeModeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Theme Demo',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: _getThemeMode(themeNotifier.themeModeType),
            home: MyHomePage(),
          );
        },
      ),
    );
  }

  ThemeMode _getThemeMode(ThemeModeType modeType) {
    switch (modeType) {
      case ThemeModeType.light:
        return ThemeMode.light;
      case ThemeModeType.dark:
        return ThemeMode.dark;
      case ThemeModeType.system:
      default:
        return ThemeMode.system;
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // ThemeModeNotifierインスタンスにアクセスし、themeModeTypeプロパティを変更
                Provider.of<ThemeModeNotifier>(context, listen: false) // listem: falseにすることで、変更してもUIが変化しない
                    .themeModeType = ThemeModeType.light;
              },
              child: Text('Light Theme'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeModeNotifier>(context, listen: false)
                    .themeModeType = ThemeModeType.dark;
              },
              child: Text('Dark Theme'),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<ThemeModeNotifier>(context, listen: false)
                    .themeModeType = ThemeModeType.system;
              },
              child: Text('System Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
