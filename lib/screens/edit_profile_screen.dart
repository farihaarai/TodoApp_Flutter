import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newtodoapp/controllers/auth_controller.dart';
import 'package:newtodoapp/controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
      text: profileController.name.value,
    );

    final TextEditingController ageController = TextEditingController(
      text: profileController.age.value.toString(),
    );

    // local gender state (so dropdown works independently)
    final RxString selectedGender = profileController.gender.value.obs;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final success = await authController.updateUserProfile(
                    name: nameController.text.trim(),
                    age: int.tryParse(ageController.text) ?? 0,
                    gender: selectedGender.value,
                  );

                  if (success) {
                    Get.back(); // close screen
                    Get.snackbar("Success", "Profile updated successfully");
                  } else {
                    Get.snackbar("Error", "Failed to update profile");
                  }
                },
                child: const Text("Save Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
