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
  List<ToDo> allToDo = [];

  @override
  void initState() {
    getValues();
    super.initState();
  }

  void getValues () async {
    allToDo = await ToDoDataBase.instance.readAllToDo();
  }

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
                setState(() {
                });
              },
              icon: Icon(Icons.cloud_download))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: allToDo.length,
              itemBuilder: (context, index) => ToDoViewWidget(toDo: allToDo[index],)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'get',
        child: const Icon(Icons.add),
      ),
    );
  }
}


class ToDoViewWidget extends StatelessWidget {
  const ToDoViewWidget({Key? key, required this.toDo}) : super(key: key);
  final ToDo toDo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('${toDo.localId}'),
        title: Text(toDo.title),
        trailing: toDo.completed ? Icon(Icons.check) : Icon(Icons.do_not_disturb),
      ),
    );
  }
}
