import 'package:flutter/material.dart';
import './poke_detail.dart';

void main() {
  runApp(const MyApp());
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: TopPage(),
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.lightbulb),
          title: Text('Dark/Light Mode'),
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ThemeModeSelectionPage(),
            ))
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

class ThemeModeSelectionPage extends StatelessWidget {
  const ThemeModeSelectionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: ThemeMode.system,
              title: const Text('System'),
              onChanged: (newValue) {},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: ThemeMode.system,
              title: const Text('Light'),
              onChanged: (newValue) {},
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: ThemeMode.system,
              title: const Text('Dark'),
              onChanged: (newValue) {},
            ),
          ],
        ),
      ),
    );
  }
}