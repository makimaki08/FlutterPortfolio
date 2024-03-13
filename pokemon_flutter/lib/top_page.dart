import 'utils/utils.dart';
import './poke_detail.dart';
import 'utils/manage_mode.dart';

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
