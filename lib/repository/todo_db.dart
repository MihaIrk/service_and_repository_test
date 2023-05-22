import 'package:service_and_repository_test/models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Абстрактный класс для определения сервиса взаимодействия с локальной частью,
/// в нем создаем методы с помощью которых мы будем работать с базой данный,
/// сохранять задачи на устройство, получать из базы данных список всех дел или конкретное дело,
/// так же изменять содержимое или удалять какое либо дело. Так же тут можно создать методы для взаимодействия локальной и онлайн БД.
/// Это нужно для того что бы мы могли например создавать две разных локальных БД,
/// приэтом методы для взаимодействия с ними будет один и тот же.
abstract class LocalRepository {
  Future createToDo(ToDo toDo);
  Future<ToDo> readToDo(int toDoLocalId);
  Future<List<ToDo>> readAllToDo();
  Future updateToDo(ToDo toDo);
  Future deleteToDo(int toDoLocalId);
}

/// Наследуемся от LocalRepository реализуем хранение данных через sqLite БД, описываем создание БД,
/// определяем методы для записи, удаления, или обновления задач.
class ToDoDataBase extends LocalRepository{
  final String _tableName = 'tableToDo';
  static final ToDoDataBase instance = ToDoDataBase._init();
  static Database? _database;
  ToDoDataBase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future <Database>initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todoDB');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    await db.execute(
      '''CREATE TABLE $_tableName (
      localId INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      id INTEGER NOT NULL,
      title TEXT NOT NULL,
      completed BOOLEAN NOT NULL   
      )'''
    );
  }
  @override

  Future createToDo (ToDo toDo) async {
    final db = await instance.database;
    db.insert(_tableName, toDo.toMap());
  }


  @override
  Future<List<ToDo>> readAllToDo() async{
    final db = await instance.database;
    final results = await db.query(_tableName);
    return results.map((e) => ToDo.fromMap(e)).toList();
  }

  @override
  Future<ToDo> readToDo(int toDoLocalId) async {
    final db = await instance.database;
    final map = await db.query(
      _tableName,
      columns: ['localId','userId','id','title','completed'],
      where: 'localId = ?',
      whereArgs: [toDoLocalId],
    );
    if (map.isNotEmpty) {
      return ToDo.fromMap(map.first);
    }
    else{
      throw Exception('$toDoLocalId is Not Found');
    }
  }

  @override
  Future updateToDo (ToDo toDo) async {
    final db = await instance.database;
    await db.update(
      _tableName,
      toDo.toMap(),
      where: 'localId = ?',
      whereArgs: ['${toDo.localId}']
    );
  }

  @override
  Future deleteToDo (int toDoLocalId) async {
    final db = await instance.database;
    db.delete(
      _tableName,
      where: 'localId =?',
      whereArgs: ['$toDoLocalId'],
    );
  }
  Future closeDB () async {
    final db = await instance.database;
    db.close();
  }

}