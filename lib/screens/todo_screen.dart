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
  TodoScreen({super.key});
  final AuthController authController = Get.find();
  final TodoController todoController = Get.find();
  final ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

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
              if (value == "logout") {
                logoutUser();
              } else if (value == "change_password") {
                openChangePasswordScreen();
              } else if (value == "edit_profile") {
                openEditProfileScreen();
              }
            },
            itemBuilder: (context) => [
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
                ElevatedButton(
                  onPressed: () {
                    _addTodo(todoController, textController.text);
                    textController.clear();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _todoList(todoController),
          ],
        ),
      ),
    );
  }

  Widget _todoList(TodoController todoController) {
    return Expanded(
      child: Obx(() {
        int itemCount = todoController.todos.length;
        if (itemCount == 0) {
          return Text("No To-Dos found. Add a new one to continue.");
        }
        return ListView.builder(
          itemCount: itemCount,
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
                        onPressed: () => _editTodo(todoController, todo),
                        icon: const Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed: todo.isCompleted.value
                            ? () => _deleteTodo(todoController, todo)
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
        );
      }),
    );
  }

  void _addTodo(TodoController todoController, String text) {
    if (text.trim().isEmpty) return;
    todoController.addTodo(text.trim());
    // textController.clear();
  }

  void _editTodo(TodoController todoController, Todo todo) {
    todoController.editedTodo.value = todo;
    Get.to(EditTodoScreen());
  }

  void _deleteTodo(TodoController todoController, Todo todo) {
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
    print("Opening EditProfileScreen...");
    Get.to(() => EditProfileScreen());
  }
}
