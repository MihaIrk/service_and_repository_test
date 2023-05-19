import 'package:dio/dio.dart';
import 'package:service_and_repository_test/models/todo.dart';

import '../models/todo.dart';

abstract class WebService {
  Future <List<ToDo>> getToDoFromWeb();
  Future addToDoInWeb(ToDo toDo);
}



class RealWebService extends WebService {
  final dio = Dio();
  @override
  Future<List<ToDo>> getToDoFromWeb() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/todos');
    final testList = response.data as List<dynamic>;
    final List<ToDo> todo = testList.map((e) => ToDo.fromJson(e as Map<String, dynamic>)).toList();
    return todo;
  }

  @override
  Future addToDoInWeb(ToDo toDo) async {
    final request = await dio.post('https://jsonplaceholder.typicode.com/todos');
    print(request.data);
  }
}