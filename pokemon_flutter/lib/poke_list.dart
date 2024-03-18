import '../utils/utils.dart';

import './poke_detail.dart';

// PokemonListを表示するためのクラス
class PokeList extends StatelessWidget {
  const PokeList({super.key});
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
  const PokeListItem({super.key, required this.index});
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