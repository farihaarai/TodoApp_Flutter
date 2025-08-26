import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:newtodoapp/screens/todo_screen.dart';
// import 'package:newtodoapp/screens/todo_screen.dart';
// import 'package:get/get.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';
import 'package:newtodoapp/controllers/profile_controller.dart';
import 'package:newtodoapp/controllers/todo_controller.dart';
import 'package:newtodoapp/models/todo.dart';
import 'package:newtodoapp/screens/todo_screen.dart';

void main() {
  Get.put(AuthController());
  Get.put(TodoController());
  Get.put(ProfileController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      // home: LoginScreen(),
      home: TodoScreen(),
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
        useMaterial3: false,
      ),
      // home: TodoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
