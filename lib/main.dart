import 'package:flutter/material.dart';
import 'package:service_and_repository_test/services/todo_db.dart';
import 'package:service_and_repository_test/services/web_service.dart';

import 'models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() async {
    final twentyToDo = await ToDoDataBase.instance.readToDo(20);
    print(twentyToDo);
    final newToDo = ToDo(localId:twentyToDo.localId,userId: twentyToDo.userId, id: twentyToDo.id, title: 'k12345678', completed: twentyToDo.completed);
    await ToDoDataBase.instance.updateToDO(newToDo);
    final testUpdateTodo = await ToDoDataBase.instance.readToDo(20);
    print(testUpdateTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () async {
                List<ToDo> toDos = await RealWebService().getToDoFromWeb();
                for (var element in toDos) {
                  ToDoDataBase.instance.createToDo(element);
                }
              },
              icon: Icon(Icons.cloud_download))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'get',
        child: const Icon(Icons.add),
      ),
    );
  }
}
