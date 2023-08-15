import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo.provider.dart';

class AddPage extends ConsumerWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Add Todo")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: todoTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(todoProvider.notifier)
                    .addTodo(todoTextController.text);
                Navigator.pop(context);
              },
              child: const Text("Add Todo"),
            )
          ],
        ),
      ),
    );
  }
}
