import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/todo_card.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, value, child) {
        final incompleteList =
            value.todoList.where((element) => !element.isComplete).toList();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: incompleteList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return TodoCard(
                uuid: incompleteList[index].uuid,
                isComplete: incompleteList[index].isComplete,
                title: incompleteList[index].title,
                description: incompleteList[index].description,
              );
            },
          ),
        );
      },
    );
  }
}
