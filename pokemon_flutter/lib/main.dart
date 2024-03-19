import 'utils/utils.dart';
import 'utils/manage_mode.dart';

import './top_page.dart';

/*
  ChangeNotifierProviderの利用方法って本当にあっている？
  →サンプルDemoと見比べて、違いを確認
    →おそらくmain関数の呼び出しは少し修正するくらい
    →Provider.ofで変更した値をmainに渡す処理が正しく動作していないのでは？
      →ThemeModeNotifierのinitが、引数にprefを要求しているため、runAppでChangeNotifierを呼び出していた
      →runAppでChangeNotifierProviderを呼び出す方法に変える⭐️ToDo
  →MyAppと、MyHomePageって、2つに別れているけど分ける必要あるの？
    →同じような宣言繰り返しているだけで、本当は意味ないのでは？
 */

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Flutter EngineとFlutter Frameworkを通信できるようにするために設定
  // 下記で、ローカルで変更したThemeModeを保存できるように定義
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);

  // アプリを実装
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String appTitle = 'PokeAPI Demo';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeModeNotifier(),
      child: Consumer<ThemeModeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: appTitle,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeNotifier.mode,
            home: TopPage(),
          );
        },
      ),
    );
  }
}
