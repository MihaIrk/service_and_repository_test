import 'package:service_and_repository_test/repository/todo_db.dart';
import 'package:service_and_repository_test/repository/web_repository.dart';

import '../models/todo.dart';



/// Абстрактный класс сервиса, описывает все варианты взаимодействий с данными которые мы бы хотели видеть,
/// это нужно для того что бы нам не приходилось в случае чего переписывать что-либо непосредственно во view классах.
/// Сервис является удобным местом для хранения всех важных и нужных функций для работы с данными.
abstract class ToDoService {
  void createLocalToDo(ToDo toDo);
  void createWebToDo(ToDo toDo);
  Future<ToDo> getLocalToDO(int localId);
  Future<ToDo> getWebToDo(int id);
  Future<List<ToDo>> getAllLocalToDo();
  Future<List<ToDo>> getAllWebToDo();
  void updateLocalToDo(ToDo toDo);
  void updateWebToDo(ToDo toDo);
  void deleteLocalToDo(int localId);
  void deleteWebToDo(int id);
  void deleteToDoEveryWhere(int localId, int id);
  void loadToDoInBaseFromWeb();
}

/// Представляет собой непосредственно реализацию сервиса работы с данными,
/// тут мы определяем какой метод куда или откуда будет записывать или считывать данные,
/// это очень удобно потому что если мы решим изменить способ хранения даныых,
/// или порядок выполнения каких либо действий, мы просто сможем изменить это тут,
/// и оно затронет все участки программы где происходит обращение к сервису.
class ToDoStorageService extends ToDoService {
  @override
  void createLocalToDo(ToDo toDo) {
    ToDoDataBase.instance.createToDo(toDo);
  }

  @override
  void createWebToDo(ToDo toDo) {
    RealWebRepository().createToDoInWeb(toDo);
  }

  @override
  void deleteLocalToDo(int localId) {
    ToDoDataBase.instance.deleteToDo(localId);
  }

  @override
  void deleteToDoEveryWhere(int localId, int id) async {
    await ToDoDataBase.instance.deleteToDo(localId);
    RealWebRepository().delete(id);
  }

  @override
  void deleteWebToDo(int id) {
    RealWebRepository().delete(id);
  }

  @override
  Future<List<ToDo>> getAllLocalToDo() async {
    List<ToDo> toDos = await ToDoDataBase.instance.readAllToDo();
    return toDos;
  }

  @override
  Future<List<ToDo>> getAllWebToDo() async {
    List<ToDo> toDos = await RealWebRepository().getAllToDoFromWeb();
    return toDos;
  }

  @override
  Future<ToDo> getLocalToDO(int localId) async {
    final todo = await ToDoDataBase.instance.readToDo(localId);
    return todo;
  }

  @override
  Future<ToDo> getWebToDo(int id) async {
    final todo =  await RealWebRepository().getToDo(id);
    return todo;
  }

  @override
  void updateLocalToDo(ToDo toDo) {
    ToDoDataBase.instance.updateToDo(toDo);
  }

  @override
  void updateWebToDo(ToDo toDo) {
    RealWebRepository().updateToDo(toDo);
  }

  @override
  void loadToDoInBaseFromWeb() async {
    List<ToDo>toDos = await RealWebRepository().getAllToDoFromWeb();
    for (var element in toDos) {
      await ToDoDataBase.instance.createToDo(element);
    }
  }
}