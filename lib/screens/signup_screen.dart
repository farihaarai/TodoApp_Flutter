import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodoapp/app_router.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final RxString name = ''.obs;
    final RxString email = ''.obs;
    final RxString password = ''.obs;
    final RxInt age = 0.obs;
    final RxString selectedGender = 'f'.obs;
    // Reactive error
    final RxString error = ''.obs;

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => name.value = val,
              decoration: const InputDecoration(labelText: 'Name'),
            ),

            TextField(
              onChanged: (val) => email.value = val,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            TextField(
              onChanged: (val) => age.value = int.tryParse(val) ?? 0,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),

            TextField(
              onChanged: (val) => password.value = val,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Gender: "),
                Obx(
                  () => DropdownButton<String>(
                    value: selectedGender.value,
                    items: ["f", "m"]
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (val) => selectedGender.value = val ?? "f",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleSignup(
                name.value,
                email.value.trim(),
                age.value,
                password.value,
                selectedGender.value,
                error,
              ),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 10),
            Obx(
              () =>
                  Text(error.value, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  void handleSignup(
    String name,
    String email,

    int age,
    String password,
    String selectedGender,
    Rx<String> error,
  ) async {
    // Check if any field is empty or invalid.
    if (name.isEmpty || email.isEmpty || password.isEmpty || age == 0) {
      error.value = "Please fill all details";
      return; // Stop here if validation fails.
    }

    // Call signup function from AuthController to save user.
    bool success = await authController.signup(
      name: name,
      email: email,
      age: age,
      password: password,
      gender: selectedGender,
    );

    // After successful signup, go back to LoginScreen.
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => LoginScreen()),
    // );
    if (success) {
      // only navigate if signup worked
      Get.offNamed(AppRouter.todoscreen);
    } else {
      error.value = "Signup failed. Try again.";
    }
  }
}
