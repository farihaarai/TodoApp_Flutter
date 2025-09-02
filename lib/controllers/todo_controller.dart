import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newtodoapp/controllers/auth_controller.dart';
import 'package:newtodoapp/controllers/base_api_controller.dart';
import '../models/todo.dart';

class TodoController extends BaseApiController {
  // This is a reactive list of todos.
  // Whenever items are added/removed/changed, the UI will update automatically.
  final RxList<Todo> todos = <Todo>[].obs;
  AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();
    fetchUserTodo(); // load todos right after controller is created
  }
  // Method to add a new todo by making id as current datetime
  // void addTodo(String description) {
  //   todos.add(
  //     Todo(id: DateTime.now().millisecondsSinceEpoch, description: description),
  //   );
  // }

  // Method to add a new todo by making id icremented using counter
  int nextId = 1; // counter starts at 1
  final Rx<Todo?> editedTodo = Rx<Todo?>(null);

  Future<bool> fetchUserTodo() async {
    final url = Uri.parse('$baseUrl/user/toDo');

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${authController.token.value}'},
    );
    print("Todos response: ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      for (var item in data) {
        item["isCompleted"] = item["isCompleted"] ?? false;
        todos.add(Todo.fromJson(item));
      }
      return true;
    }
    return false;
  }

  // void addTodo(String description) {
  //   todos.add(Todo(id: nextId, description: description));
  //   nextId++; // increase counter for next todo
  // }
  Future<bool> addTodo(String description) async {
    final url = Uri.parse('$baseUrl/user/toDo');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authController.token.value}',
      },
      body: jsonEncode({"description": description}),
    );
    print("Add Todo response: ${response.statusCode} ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      // Update the list in UI
      todos.add(Todo.fromJson(data));

      return true;
    } else {
      print("Todo not added: ${response.statusCode}");
      return false;
    }
  }

  // Method to edit an existing todo
  // void editTodo(int id, String description) {
  //   // Update the reactive description value at that index
  //   Todo? todo = todos.firstWhereOrNull((todo) => todo.id == id);
  //   todo?.description.value = description;
  // }
  Future<bool> editTodo(int id, String description) async {
    final url = Uri.parse('$baseUrl/user/toDo/$id');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authController.token.value}',
      },
      body: jsonEncode({"description": description}),
    );

    print("edit todo response: ${response.statusCode} ${response.body}");
    if (response.statusCode == 200) {
      Todo? todo = todos.firstWhereOrNull((todo) => todo.id == id);
      todo?.description.value = description;
      return true;
    } else {
      print("Failed to edit todo: ${response.statusCode}");
      return false;
    }
  }

  // Method to delete a todo (by index)
  // void deleteTodo(int id) {
  //   todos.removeWhere((todo) => todo.id == id);
  // }
  Future<bool> deleteTodo(int id) async {
    final url = Uri.parse('$baseUrl/user/toDo/$id');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authController.token.value}',
      },
      body: jsonEncode({"id": id}),
    );
    if (response.statusCode == 200) {
      todos.removeWhere((todo) => todo.id == id);
      return true;
    } else {
      return false;
    }
  }

  // Method to mark todo as completed or not
  void toggleTodoStatus(int index) {
    todos[index].isCompleted.value = !todos[index].isCompleted.value;
  }
}
