import 'utils/utils.dart';

import './poke_list.dart';
import './setting/setting_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});
  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int _currentbnb = 0; // 現在のButtomBarの状態を保持するための変数

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // _currentbnbの値により、表示させる画面を変更
          child: _currentbnb == 0 ? const PokeList() : const Settings()
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
