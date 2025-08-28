import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:newtodoapp/controllers/auth_controller.dart';
import 'package:newtodoapp/controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    // final AuthController authController = Get.put(AuthController());
    final TextEditingController nameController = TextEditingController(
      text: profileController.name.value,
    );

    final TextEditingController ageController = TextEditingController(
      text: profileController.age.value.toString(),
    );
    final RxString selectedGender = profileController.gender.value.obs;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Age"),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Gender: "),
                DropdownButton<String>(
                  value: selectedGender.value,
                  items: ["f", "m"]
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (val) => selectedGender.value = val ?? "f",
                ),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveProfile(nameController, ageController, selectedGender);
              },
              child: const Text("Save Profile"),
            ),
          ],
        ),
      ),
    );
  }

  void saveProfile(
    TextEditingController nameController,

    TextEditingController ageController,
    Rx<String> selectedGender,
  ) {
    profileController.updateProfile(
      name: nameController.text.trim(),
      age: int.tryParse(ageController.text) ?? 0,
      gender: selectedGender.value,
    );
    // Navigator.pop(context);
    Get.back();
  }
}
