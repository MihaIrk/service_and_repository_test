import 'package:flutter/material.dart';
import 'package:service_and_repository_test/screens/add_new_toDo.dart';
import 'package:service_and_repository_test/screens/cloud_todo_screen.dart';
import 'package:service_and_repository_test/screens/widgets/toDoViewWidget.dart';
import 'package:service_and_repository_test/services/todo_service.dart';
import '../models/todo.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
    allToDo = await ToDoStorageService().getAllLocalToDo();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список дел'),
        actions: [
          IconButton(
              onPressed: () {
                getValues();
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CloudToDoScreen()));
              },
              icon: const Icon(Icons.cloud),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Загрузить из облака на телефон?'),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ToDoStorageService().loadToDoInBaseFromWeb();
                          setState(() {
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('ДА'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('НЕТ'),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.cloud_download),
          ),
        ],
      ),
      body: allToDo.isEmpty ? const Center(child: Text('Список дел пуст'),) : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: allToDo.length,
              itemBuilder: (context, index) => ToDoViewWidget(toDo: allToDo[index],refresh: getValues,)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewToDo(),
            ),
          );
        },
        tooltip: 'get',
        child: const Icon(Icons.add),
      ),
    );
  }
}