import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoList = context.select<TodoProvider, List<Todo>>(
      (provider) => provider.todoList,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: todoList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return TodoCard(
            isComplete: todoList[index].isComplete,
            title: todoList[index].title,
            description: todoList[index].description,
          );
        },
      ),
    );
  }
}
