import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Access AuthController (to create new users).
    final AuthController authController = Get.find();

    final RxString name = ''.obs;
    final RxString email = ''.obs;
    final RxString password = ''.obs;
    final RxInt age = 0.obs;
    final RxString selectedGender = 'f'.obs;
    // Reactive error
    final RxString error = ''.obs;
    // Function to handle signup process.
    void handleSignup() {
      // Check if any field is empty or invalid.
      if (name.value.isEmpty ||
          email.value.isEmpty ||
          password.value.isEmpty ||
          age.value == 0) {
        error.value = "Please fill all details";
        return; // Stop here if validation fails.
      }

      // Call signup function from AuthController to save user.
      authController.signup(
        name: name.value,
        email: email.value,
        age: age.value,
        password: password.value,
        gender: selectedGender.value,
      );

      // After successful signup, go back to LoginScreen.
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => LoginScreen()),
      // );
      Get.off(LoginScreen());
    }

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
              onChanged: (val) => email.value,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            TextField(
              onChanged: (val) => age.value,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),

            TextField(
              onChanged: (val) => password.value,
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
              onPressed: () => handleSignup(),
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
}
