import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/arguments/editroute_arguments.dart';
import 'package:todo_app/providers/todo_provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as EditRouteArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TodoProvider>().delete(args.uuid);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController..text = args.title,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              minLines: 3,
              maxLines: 3,
              controller: descriptionController..text = args.description,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    context.read<TodoProvider>().update(
                          args.uuid,
                          null,
                          titleController.text != args.title
                              ? titleController.text
                              : null,
                          descriptionController.text != args.description
                              ? descriptionController.text
                              : null,
                        );
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
