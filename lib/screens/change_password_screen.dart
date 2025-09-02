import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final RxString oldPass = ''.obs;
    final RxString newPass = ''.obs;
    final RxString confirmPass = ''.obs;
    final RxString message = ''.obs;

    void handleChangePassword() {
      if (newPass.value != confirmPass.value) {
        message.value = "New passwords do not match ";
        return;
      }
      if (oldPass.value.isEmpty || newPass.value.isEmpty) {
        message.value = "Password cannot be empty ";
        return;
      }

      authController.updateUserPassword(
        currentPassword: oldPass.value,
        newPassword: newPass.value,
      );

      message.value = "Password changed successfully";

      Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (val) => oldPass.value = val,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Old Password"),
            ),
            TextField(
              onChanged: (val) => newPass.value = val,
              obscureText: true,
              decoration: const InputDecoration(labelText: "New Password"),
            ),

            TextField(
              onChanged: (val) => confirmPass.value = val,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirm Password"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleChangePassword,
              child: const Text("Change Password"),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Text(
                message.value,
                style: TextStyle(
                  color: message.contains("success")
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
