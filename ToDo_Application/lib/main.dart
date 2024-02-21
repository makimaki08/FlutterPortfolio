import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // runApp(const MyApp()); // constで定義すると、ScopedModelの利点である、StatelessWidgetだけでの管理ができなくなる
  runApp(new MyApp(ToDoModel()));
}

class MyApp extends StatelessWidget {
  // ScopedModelを利用するため、ToDoModelをインスタンス化
  final ToDoModel toDoModel;
  MyApp(this.toDoModel, {Key? key}) : super(key: key); // MyAppとcounterモデルを初期化

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Scoped Model ToDo Apps',
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      // 共通でmodelを使用したいルート(親)Widgetにて、WidgetをWrapするように定義する
      home: ScopedModel<ToDoModel>(
        model: toDoModel,
        child: new MyHomePage('Scoped Model ToDo Apps'),
      ),
    );
  }
}

// setStateを利用せずにToDoListを表示するために利用するModel
class ToDoModel extends Model {
  List<String> _toDoList = ['Demo ToDo1', 'Demo ToDo2', 'Demo ToDo3'];
  List<String> get toDoList => _toDoList;

  void addToDoList() {
    _toDoList.add('Add ToDo'); // Demo用に同じToDoを挿入
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage(this.title);
  // MyHomePage(this.title, {Key? key}) : super(key: key);

  // To Doアプリに設定する、Demo用のデータ
  final _demoItems = ['Demo ToDo1', 'Demo ToDo2', 'Demo ToDo3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // ToDoアプリのため、リスト型に変更
      body: Center(
        child: ListView.builder(
          itemCount: _demoItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_demoItems[index]),
            );
          },
        ),
      ),
      floatingActionButton: ScopedModelDescendant<ToDoModel> (
        builder: (context, child, model) {
          return FloatingActionButton(
            // onPressedで、表示するToDoを追加するように処理
            onPressed: () {
              _demoItems.add('Add Demo ToDo');
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),

            // onPressed: () => model.incrementCounter(),
            // tooltip: 'Increment',
            // child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}