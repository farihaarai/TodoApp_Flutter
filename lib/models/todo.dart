import 'package:get/get.dart';

class Todo {
  final int id;
  RxString description;
  RxBool isCompleted;

  Todo({
    required this.id,
    required String description,
    bool isCompleted = false,
  }) : description = description.obs,
       isCompleted = isCompleted.obs;
}
