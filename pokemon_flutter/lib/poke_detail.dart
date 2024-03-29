import '../utils/utils.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .inversePrimary,
            title: const Text('pikachu'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32),
                        child: Image.network(
                          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                          height: 300,
                          width: 300,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text(
                          'No.25',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  const Text(
                    'pikachu',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const Chip(
                    label: Text('electric'),
                    backgroundColor: Colors.yellow,
                  )
                ],
              )
          ),
        )
    );
  }
}