import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodoapp/app_router.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // reactive fields instead of TextEditingController
    final RxString email = ''.obs;
    final RxString password = ''.obs;
    final RxString error = ''.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // email reactive
            TextField(
              onChanged: (val) => email.value = val,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            //password reactive
            TextField(
              onChanged: (val) => password.value = val,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () =>
                  handleLogin(error, email.value.trim(), password.value),
              child: const Text('Login'),
            ),

            const SizedBox(height: 10),

            // error reactive
            Obx(
              () =>
                  Text(error.value, style: const TextStyle(color: Colors.red)),
            ),

            TextButton(
              onPressed: () {
                Get.toNamed(AppRouter.signupscreen);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => SignupScreen()),
                // );
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  void handleLogin(Rx<String> error, String email, String password) {
    final AuthController authController = Get.find();
    bool success = authController.login(email, password);

    if (success) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const TodoScreen()),
      // );
      Get.offNamed(AppRouter.todoscreen);
    } else {
      error.value = "Wrong Password 123";
    }
  }
}
