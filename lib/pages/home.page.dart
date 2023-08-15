import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo.model.dart';
import 'package:todo/pages/add.page.dart';
import 'package:todo/providers/todo.provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TodoModel> todos = ref.watch(todoProvider);
    List<TodoModel> activeTodos = todos
        .where(
          (todo) => todo.completed == false,
        )
        .toList();
    List<TodoModel> completedTodos = todos
        .where(
          (todo) => todo.completed == true,
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: ListView.builder(
        itemCount: activeTodos.length + 1,
        itemBuilder: (context, index) {
          if (index == activeTodos.length) {
            if (completedTodos.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Completed Todos"),
                ),
              );
            }
          } else {
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      ref
                          .read(todoProvider.notifier)
                          .deleteTodo(todos[index].todoId);
                    },
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                  )
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      ref
                          .read(todoProvider.notifier)
                          .completeTodo(todos[index].todoId);
                    },
                    backgroundColor: Colors.green,
                    icon: Icons.check,
                  )
                ],
              ),
              child: ListTile(
                title: Text(activeTodos[index].content),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
            ),
          );
        },
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}
