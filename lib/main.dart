import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:newtodoapp/screens/todo_screen.dart';
// import 'package:newtodoapp/screens/todo_screen.dart';
// import 'package:get/get.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';
import 'package:newtodoapp/controllers/profile_controller.dart';
import 'package:newtodoapp/controllers/todo_controller.dart';
import 'screens/login_screen.dart';

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
      title: 'Todo Login App',
      home: LoginScreen(),
      // home: TodoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
