import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Cat>()])
import 'cat.mocks.dart';

class Cat {
  // 実行したらMeowを返すメソッド
  String sound() => 'Meow';

  // 引数が必要で、実行したらtureを返すメソッド
  bool eatFood(String food, {bool? hungry}) => true;

  // 非同期でprintを実行するメソッド
  Future<void> chew() async => print("Chewing...");

  int walk(List<String> places) => 7;

  void sleep() {}
  void hunt(String place, String prey) {}
  int lives = 9;

  int getLives() {
    int tmpLives = 2;
    // やはりここの変数を、テスト側から変更させることはできない。。。
    tmpLives += 2;
    return tmpLives;
  }
}

void main() {
  test('sound', () {
    var cat = MockCat();
    cat.sound();
    verify(cat.sound());
  });

  test('lives', () {
    var cat = MockCat();
    when(cat.lives).thenReturn(2);
    expect(cat.lives, 2);
  });

  test('getLives', () {
    var cat = MockCat();
    // when(cat.getLives.).thenReturn(2);
    // expect(cat.lives, 2);
  });
}
