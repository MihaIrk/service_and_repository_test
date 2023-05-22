import 'package:flutter/material.dart';
import 'package:service_and_repository_test/services/todo_db.dart';
import '../../models/todo.dart';

class ToDoViewWidget extends StatelessWidget {
  const ToDoViewWidget({Key? key, required this.toDo, required this.refresh}) : super(key: key);
  final Function refresh;
  final ToDo toDo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        child: ListTile(
          leading: Text('${toDo.localId}'),
          title: Text(toDo.title),
          subtitle: toDo.completed ? const Text('Выполнено',style: TextStyle(color: Colors.green), ) : const Text('Не выполнено', style: TextStyle(color: Colors.red),),
          trailing: IconButton(onPressed: (){ToDoDataBase.instance.deleteToDO(toDo.localId!); refresh();}, icon: const Icon(Icons.delete),),
        ),
      ),
    );
  }
}

class ToDoWebViewWidget extends StatelessWidget {
  const ToDoWebViewWidget({Key? key, required this.toDo,}) : super(key: key);
  final ToDo toDo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('${toDo.id}'),
        title: Text(toDo.title),
        subtitle: toDo.completed ? const Text('Выполнено',style: TextStyle(color: Colors.green),) : const Text('Не выполнено', style: TextStyle(color: Colors.red),),
      ),
    );
  }
}
