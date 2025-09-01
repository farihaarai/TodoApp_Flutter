import 'package:get/get.dart';
import 'package:newtodoapp/controllers/base_api_controller.dart';
import '../models/todo.dart';

class TodoController extends BaseApiController {
  // This is a reactive list of todos.
  // Whenever items are added/removed/changed, the UI will update automatically.
  final RxList<Todo> todos = <Todo>[].obs;

  // Method to add a new todo by making id as current datetime
  // void addTodo(String description) {
  //   todos.add(
  //     Todo(id: DateTime.now().millisecondsSinceEpoch, description: description),
  //   );
  // }

  // Method to add a new todo by making id icremented using counter
  int nextId = 1; // counter starts at 1
  final Rx<Todo?> editedTodo = Rx<Todo?>(null);

  void addTodo(String description) {
    todos.add(Todo(id: nextId, description: description));
    nextId++; // increase counter for next todo
  }
  // Future<bool> addTodo(String description) async {
  //   final url = Uri.parse('$baseUrl/')
  // }

  // Method to edit an existing todo
  void editTodo(int id, String description) {
    // Update the reactive description value at that index
    Todo? todo = todos.firstWhereOrNull((todo) => todo.id == id);
    todo?.description.value = description;
  }

  // Method to delete a todo (by index)
  void deleteTodo(int id) {
    todos.removeWhere((todo) => todo.id == id);
  }

  // Method to mark todo as completed or not
  void toggleTodoStatus(int index) {
    todos[index].isCompleted.value = !todos[index].isCompleted.value;
  }
}
