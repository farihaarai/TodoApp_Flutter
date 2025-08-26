import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';
import 'package:newtodoapp/controllers/todo_controller.dart';
import 'package:newtodoapp/controllers/profile_controller.dart';
import 'package:newtodoapp/models/todo.dart';

import 'login_screen.dart';
import 'edit_todo_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final TodoController todoController = Get.find();
    final ProfileController profileController = Get.find();

    final TextEditingController textController = TextEditingController();

    void addTodo() {
      if (textController.text.trim().isEmpty) return;
      todoController.addTodo(textController.text.trim());
      textController.clear();
    }

    // void editTodo(Todo todo) async {
    //   final updatedText = await Navigator.push<String>(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) =>
    //           EditTodoScreen(initialText: todo.description.value),
    //     ),
    //   );

    //   if (updatedText != null && updatedText.isNotEmpty) {
    //     todoController.editTodo(todo.id, updatedText);
    //   }
    // }
    void editTodo(Todo todo) {
      todoController.editedTodo.value = todo;
      Get.to(EditTodoScreen());
    }

    void deleteTodo(Todo todo) {
      todoController.deleteTodo(todo.id);
    }

    void logoutUser() {
      authController.logout();
      Get.off(LoginScreen());
    }

    // void openChangePasswordScreen() async {
    //   final updatedPassword = await Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
    //   );
    //   if (updatedPassword != null) {
    //     authController.updateUserPassword(updatedPassword);
    //   }
    // }

    void openChangePasswordScreen() {
      Get.to(() => const ChangePasswordScreen());
    }

    void openEditProfileScreen() {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const EditProfileScreen()),
      // );
      Get.to(EditProfileScreen());
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Hi, ${profileController.name.value} '
            '(${profileController.gender.value}) '
            '${profileController.age.value}',
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "logout") logoutUser();
              if (value == "change_password") openChangePasswordScreen();
              if (value == "edit_profile") openEditProfileScreen();
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'edit_profile', child: Text('Edit Profile')),
              PopupMenuItem(
                value: 'change_password',
                child: Text('Change Password'),
              ),
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a new todo here',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: addTodo, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: todoController.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoController.todos[index];
                    return Obx(
                      () => ListTile(
                        leading: Checkbox(
                          value: todo.isCompleted.value,
                          onChanged: (val) {
                            todoController.toggleTodoStatus(index);
                          },
                        ),
                        title: Text(
                          todo.description.value,
                          style: TextStyle(
                            decoration: todo.isCompleted.value
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => editTodo(todo),
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: todo.isCompleted.value
                                    ? () => deleteTodo(todo)
                                    : null,
                                icon: Icon(
                                  Icons.delete,
                                  color: todo.isCompleted.value
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
