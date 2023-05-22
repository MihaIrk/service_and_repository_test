import 'package:dio/dio.dart';
import 'package:service_and_repository_test/models/todo.dart';

/// Абстрактный класс для определения сервиса взаимодействия с онлайн частью,
/// в нем создаем методы с помощью которых мы будем работать с онлайн базой данный,
/// сохранять задачи на сервер, получать с него список всех дел или конкретное дело,
/// так же изменять содержимое или удалять какое либо дело.
/// Это нужно для того что бы мы могли например быстро сменить сервис хранения данных если у нас возникла такая необходимость,
/// приэтом методы для взаимодействия с сервером не изменятся.
abstract class WebRepository {
  void createToDoInWeb(ToDo toDo);
  Future <ToDo> getToDo(int id);
  Future <List<ToDo>> getAllToDoFromWeb();
  void updateToDo(ToDo toDo);
  void delete(int id);
}

/// Реализация класса онлайн хранилища, внутри данного класса мы уже можем решить каким образом мы будем работать с сервером,
/// определяем логику методов взаимодействия, решаем с помошью чего мы будем отправлять запросы на сервер,
/// реализуем доступ к онлайн БД.
class RealWebRepository extends WebRepository {
  final _dio = Dio();
  final String _path = 'https://jsonplaceholder.typicode.com/todos';

  @override
  void createToDoInWeb(ToDo toDo) async {
    final request = await _dio.post(_path, data: toDo.toJson());
    print(request.data);
  }

  @override
  Future<ToDo> getToDo(int id) async {
    final response = await _dio.get('$_path/$id');
    final toDo = ToDo.fromJson(response.data);
    return toDo;
  }

  @override
  Future<List<ToDo>> getAllToDoFromWeb() async {
    final response = await _dio.get(_path);
    final testList = response.data as List<dynamic>;
    final List<ToDo> toDos = testList.map((e) => ToDo.fromJson(e as Map<String, dynamic>)).toList();
    return toDos;
  }

  @override
  void updateToDo(ToDo toDo) async {
    await _dio.put(_path, data: toDo);
  }

  @override
  void delete(int id) async {
    await _dio.delete('$_path/$id');
  }

}


