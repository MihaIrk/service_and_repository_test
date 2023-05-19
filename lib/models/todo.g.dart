// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ToDo _$$_ToDoFromJson(Map<String, dynamic> json) => _$_ToDo(
      localId: json['localId'] as int?,
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$_ToDoToJson(_$_ToDo instance) => <String, dynamic>{
      'localId': instance.localId,
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };
