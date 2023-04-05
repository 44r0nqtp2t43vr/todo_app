import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Todo {
  bool isComplete;
  String title;
  String description;
  final String uuid;

  Todo({
    required this.isComplete,
    required this.title,
    required this.description,
  }) : uuid = const Uuid().v4();

  @override
  bool operator ==(covariant Todo other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todoList = [];
  UnmodifiableListView<Todo> get todoList => UnmodifiableListView(_todoList);

  void add(Todo todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  void update(
    String uuid,
    bool? isComplete,
    String? title,
    String? description,
  ) {
    final index = _todoList.indexWhere((element) => element.uuid == uuid);
    Todo updatedTodo = _todoList[index];
    updatedTodo.isComplete = isComplete ?? updatedTodo.isComplete;
    updatedTodo.title = title ?? updatedTodo.title;
    updatedTodo.description = description ?? updatedTodo.description;
    _todoList[index] = updatedTodo;
    notifyListeners();
  }

  void delete(String uuid) {
    _todoList.removeWhere((element) => element.uuid == uuid);
    notifyListeners();
  }
}
