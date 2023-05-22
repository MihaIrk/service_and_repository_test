import 'package:flutter/material.dart';
import 'package:service_and_repository_test/screens/widgets/toDoViewWidget.dart';
import 'package:service_and_repository_test/services/todo_service.dart';

import '../models/todo.dart';

class CloudToDoScreen extends StatefulWidget {
  const CloudToDoScreen({Key? key}) : super(key: key);

  @override
  State<CloudToDoScreen> createState() => _CloudToDoScreenState();
}

class _CloudToDoScreenState extends State<CloudToDoScreen> {
  List<ToDo> toDos = [];

  @override
  void initState() {
    super.initState();
    _getWebToDo();
  }

  Future _getWebToDo() async{
    toDos = await ToDoStorageService().getAllWebToDo();
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список дел - сервер'),
      ),
      body: toDos.isEmpty
          ? const Center(
              child: Text('Cписок дел пуст'),
            )
          : ListView.builder(
              itemCount: toDos.length,
              itemBuilder: (context, index) => ToDoWebViewWidget(
                toDo: toDos[index],
              ),
            ),
    );
  }
}
