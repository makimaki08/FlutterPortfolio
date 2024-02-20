import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // runApp(const MyApp()); // constで定義すると、ScopedModelの利点である、StatelessWidgetだけでの管理ができなくなる
  runApp(new MyApp(CounterModel()));
}

class MyApp extends StatelessWidget {
  // ScopedModelを利用するため、CounterModelをインスタンス化
  final CounterModel counterModel;
  MyApp(this.counterModel, {Key? key}) : super(key: key); // MyAppとcounterモデルを初期化

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Scoped Model ToDo Apps',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      // 共通でmodelを使用したいルート(親)Widgetにて、WidgetをWrapするように定義する
      home: ScopedModel<CounterModel>(
        model: counterModel,
        child: new MyHomePage('Scoped Model ToDo Apps'),
      ),
    );
  }
}

class CounterModel extends Model {
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // 状態を変更したら、必ずよぶメソッド
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage(this.title);
  // MyHomePage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            // Modelの情報を参照したいwidgetをScopedModelDescendantにてWrapし、builder関数を定義する
            ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) =>
              Text(
                '${model.counter}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),

      floatingActionButton: ScopedModelDescendant<CounterModel> (
        builder: (context, child, model) {
          return FloatingActionButton(
            onPressed: () => model.incrementCounter(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}