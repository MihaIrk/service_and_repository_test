import 'package:flutter/material.dart';
import 'package:service_and_repository_test/repository/todo_db.dart';
import 'package:service_and_repository_test/services/web_service.dart';

import '../models/todo.dart';


class AddNewToDo extends StatefulWidget {
  const AddNewToDo({Key? key}) : super(key: key);

  @override
  State<AddNewToDo> createState() => _AddNewToDoState();
}

class _AddNewToDoState extends State<AddNewToDo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ToDo? toDo;


  void saveToDo(String? value){
    toDo = ToDo(userId: 1,id: 87876,title: value!, completed: false);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новое дело'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Что за дело?',
              ),
              onSaved: saveToDo,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ToDoDataBase.instance.createToDo(toDo!);}
                      Navigator.pop(context);
                      },
                    child: const Text('Сохранить'),
                ),
                ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      RealWebService().addToDoInWeb(toDo!);}
                  },
                  child: const Text('Отправить в облако'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
