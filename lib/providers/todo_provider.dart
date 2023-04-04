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

  void complete() {
    isComplete = true;
  }

  void redo() {
    isComplete = false;
  }

  @override
  bool operator ==(covariant Todo other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

class TodoProvider extends ChangeNotifier {
  List<Todo> _todoList = [];
  List<Todo> _completedList = [];
  UnmodifiableListView<Todo> get todoList => UnmodifiableListView(_todoList);
  UnmodifiableListView<Todo> get completedList =>
      UnmodifiableListView(_completedList);

  void add(Todo todo) {
    List<Todo> newTodoList = _todoList.toList();
    newTodoList.add(todo);
    _todoList = newTodoList.toList();
    notifyListeners();
  }
}
