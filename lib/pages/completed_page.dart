import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/todo_card.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, value, child) {
        final completeList =
            value.todoList.where((element) => element.isComplete).toList();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            itemCount: completeList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return TodoCard(
                uuid: completeList[index].uuid,
                isComplete: completeList[index].isComplete,
                title: completeList[index].title,
                description: completeList[index].description,
              );
            },
          ),
        );
      },
    );
  }
}
