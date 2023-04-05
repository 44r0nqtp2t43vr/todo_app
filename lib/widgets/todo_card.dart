import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/arguments/editroute_arguments.dart';
import 'package:todo_app/providers/todo_provider.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.uuid,
    required this.isComplete,
    required this.title,
    required this.description,
  });

  final String uuid;
  final bool isComplete;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      constraints: const BoxConstraints(
        minHeight: 100,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  '/edit',
                  arguments: EditRouteArguments(
                    uuid: uuid,
                    title: title,
                    description: description,
                  ),
                );
              },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<TodoProvider>().delete(uuid);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/edit',
              arguments: EditRouteArguments(
                uuid: uuid,
                title: title,
                description: description,
              ),
            );
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 100,
              minWidth: double.infinity,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Checkbox(
                    value: isComplete,
                    onChanged: (value) {
                      context
                          .read<TodoProvider>()
                          .update(uuid, value, null, null);
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 16,
                      bottom: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.pink,
                          ),
                        ),
                        description.isNotEmpty
                            ? Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 20,
                                  height: 1.4,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
