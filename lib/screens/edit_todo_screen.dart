import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodoapp/controllers/todo_controller.dart';

class EditTodoScreen extends StatelessWidget {
  EditTodoScreen({super.key});
  final TodoController todoController = Get.find();
  @override
  Widget build(BuildContext context) {
    final todo = todoController.editedTodo.value!;
    // make a controller with the starting text
    final TextEditingController textController = TextEditingController(
      text: todo.description.value,
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Todo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: "Update todo"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // send the text back to previous screen
                // Navigator.pop(context, textController.text.trim());
                todoController.editTodo(todo.id, textController.text.trim());
                Get.back();
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
