import 'package:get/get.dart';

class Todo {
  final int id;
  final RxString description;
  final RxBool isCompleted;

  const Todo._({
    required this.id,
    required this.description,
    required this.isCompleted,
  });

  Todo({required int id, required String description, bool isCompleted = false})
    : this._(
        id: id,
        description: description.obs,
        isCompleted: isCompleted.obs,
      );

  factory Todo.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    String description = json['description'] as String;
    bool isCompleted = json['isCompleted'] as bool;
    return Todo._(
      id: id,
      description: description.obs,
      isCompleted: isCompleted.obs,
    );
  }
}
