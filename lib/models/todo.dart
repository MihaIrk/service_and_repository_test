import 'package:freezed_annotation/freezed_annotation.dart';


part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class ToDo with _$ToDo {
  const ToDo._();

  const factory ToDo({
    int? localId,
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _ToDo;

  factory ToDo.fromJson(Map<String, dynamic>json) => _$ToDoFromJson(json);

  Map<String, Object?> toMap() => {
    'localId': localId,
    'userId': userId,
    'id': id,
    'title': title,
    'completed': completed == true ? 1 : 0
  };

  static ToDo fromMap (Map<String, Object?> map) => ToDo(
    localId: map['localId'] as int?,
    userId: map['userId'] as int,
    id: map['id'] as int,
    title: map['title'] as String,
    completed: map['completed'] == 1,
  );

}