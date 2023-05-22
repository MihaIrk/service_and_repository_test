import 'package:dio/dio.dart';
import 'package:service_and_repository_test/models/todo.dart';
import 'package:service_and_repository_test/repository/todo_db.dart';

abstract class WebService {             //Создаю абстрактный класс для определения сервиса взаимодействия с онлайн частью
  Future <List<ToDo>> getToDoFromWeb();
  Future loadToDoInBaseFromWeb();       // Метод который должен выгружать из интернета в локальную БД
  Future addToDoInWeb(ToDo toDo);
}

class RealWebService extends WebService {  //Расширяюсь от абстрактного класса для определения методов работы с онлайном
  final _dio = Dio();
  @override
  Future<List<ToDo>> getToDoFromWeb() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/todos');
    final testList = response.data as List<dynamic>;
    final List<ToDo> toDos = testList.map((e) => ToDo.fromJson(e as Map<String, dynamic>)).toList();
    return toDos;
  }

  @override
  Future loadToDoInBaseFromWeb() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/todos');
    final testList = response.data as List<dynamic>;
    final List<ToDo> toDos = testList.map((e) => ToDo.fromJson(e as Map<String, dynamic>)).toList();
    for (var element in toDos) {
      ToDoDataBase.instance.createToDo(element);
    }
  }

  @override
  Future addToDoInWeb(ToDo toDo) async {
    final request = await _dio.post('https://jsonplaceholder.typicode.com/todos');
    print(request.data);
  }
}


