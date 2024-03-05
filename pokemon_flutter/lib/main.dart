import 'package:flutter/material.dart';
import './poke_detail.dart';
import './manage_mode.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeModeNotifier(),
    child: const MyApp(),
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

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int _currentbnb = 0; // 現在のButtomBarの状態を保持するための変数

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // _currentbnbの値により、表示させる画面を変更
        child: _currentbnb == 0 ? PokeList() : Settings()
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
            () => _currentbnb = index,
          )
        },
        currentIndex: _currentbnb,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings'
          )
        ],
      ),
    );
  }
}

// PokemonListを表示するためのクラス
class PokeList extends StatelessWidget {
  PokeList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      itemCount: 1010,
      itemBuilder: (context, index) => PokeListItem(index: index),
    );
  }
}


// Listから詳細画面に遷移させる
class PokeListItem extends StatelessWidget {
  const PokeListItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            fit: BoxFit.fitWidth,
            image: NetworkImage(
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
            )
          ),
        ),
      ),
      title: const Text(
        'pikachu',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: const Text(
        '⚡️electric'
      ),
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const PokeDetail()
          )
        )
      },
    );
  }
}

// Settings用の画面
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isSwitched = true;
  bool _isChecked = true;
  int _selectedRadio = 0;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadThemeMode().then((value) => setState(() => _themeMode = value));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.lightbulb),
          title: Text('Dark/Light Mode'),
          trailing: Text(
              (_themeMode == ThemeMode.system) ? 'System'
              : (_themeMode == ThemeMode.dark ? 'Dark' : 'Light')
          ),
          onTap: () async {
            var ret = await Navigator.of(context).push<ThemeMode>(
              MaterialPageRoute(
                builder: (context) => ThemeModeSelectionPage(mode: _themeMode),
              )
            );
            setState(() => _themeMode = ret!);
            await saveThemeMode(_themeMode);
          },
        ),
        SwitchListTile(
          title: const Text('Switch'),
          value: _isSwitched,
          onChanged: (newValue) => {
            setState((){
              _isSwitched = newValue;
            })
          },
        ),
        CheckboxListTile(
          title: const Text('Checkbox'),
          value: _isChecked,
          onChanged: (newValue) => {
            setState((){
              _isChecked = newValue!;
            })
          },
        ),
        ListTile(
          title: const Text('Radio'),
          subtitle: Column(
            children: <Widget>[
              RadioListTile(
                title: const Text('Radio 1'),
                value: 1,
                groupValue: _selectedRadio,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRadio = newValue as int;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Radio 2'),
                value: 2,
                groupValue: _selectedRadio,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRadio = newValue as int;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ThemeModeSelectionPage extends StatefulWidget {
  const ThemeModeSelectionPage({Key? key, required this.mode}) : super(key: key);
  final ThemeMode mode;

  @override
  _ThemeModeSelectionPageState createState() => _ThemeModeSelectionPageState();
}

class _ThemeModeSelectionPageState extends State<ThemeModeSelectionPage> {
  late ThemeMode _currentThemeMode;
  @override
  void initState() {
    super.initState();
    _currentThemeMode = widget.mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop<ThemeMode>(context, _currentThemeMode),
              ),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _currentThemeMode,
              title: const Text('System'),
              onChanged: (newValue) {
                setState(() {
                  _currentThemeMode = newValue!;
                });
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _currentThemeMode,
              title: const Text('Light'),
              onChanged: (newValue) {
                setState(() {
                  _currentThemeMode = newValue!;
                });
              },
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _currentThemeMode,
              title: const Text('Dark'),
              onChanged: (newValue) {
                setState(() {
                  _currentThemeMode = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}