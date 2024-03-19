import 'utils/utils.dart';
import 'utils/manage_mode.dart';

import './top_page.dart';

/*
  ChangeNotifierProviderの利用方法って本当にあっている？
  →サンプルDemoと見比べて、違いを確認
    →おそらくmain関数の呼び出しは少し修正するくらい
    →Provider.ofで変更した値をmainに渡す処理が正しく動作していないのでは？
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
  runApp(ChangeNotifierProvider(
    create: (context) => themeModeNotifier,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeAPI Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'PokeAPI Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => MaterialApp(
        title: widget.title,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const TopPage(),
      ),
    );
  }
}
