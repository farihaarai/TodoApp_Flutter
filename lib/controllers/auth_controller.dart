import 'package:get/get.dart';
import 'package:newtodoapp/controllers/profile_controller.dart';
import '../models/user.dart';

class AuthController extends GetxController {
  // This variable stores the currently logged-in user.
  // It is reactive (Rx) so UI can update automatically when user changes.
  final Rx<User?> user = Rx<User?>(null);

  User? savedUser = User(
    email: "fariha@gmail.com",
    password: "1234",
    name: "Fariha".obs, // reactive name
    age: 22.obs, // reactive age
    gender: "f".obs, // reactive gender
  );
  final ProfileController profileController = Get.put(ProfileController());
  // Method to log in a user by checking email & password
  bool login(String email, String password) {
    if (savedUser != null &&
        savedUser!.email == email.trim() &&
        savedUser!.password == password) {
      // If email and password match, set current user as savedUser
      user.value = savedUser;
      profileController.updateProfile(
        name: savedUser!.name!.value,
        age: savedUser!.age!.value,
        gender: savedUser!.gender!.value,
      );
      return true;
    } else {
      // If not matched, no user is logged in
      user.value = null;
      return false;
    }
  }

  // Method to sign up a new user
  bool signup({
    required String name,
    required String email,
    required int age,
    required String password,
    required String gender,
  }) {
    // Create a new user object with provided details
    savedUser = User(
      email: email,
      password: password,
      name: name.obs,
      age: age.obs,
      gender: gender.obs,
    );
    // Set current user as this new user
    user.value = savedUser;
    profileController.updateProfile(name: name, age: age, gender: gender);
    return true;
  }

  // Method to log out user
  void logout() {
    user.value = null;
    profileController.updateProfile(name: "", age: 0, gender: "f");
  }

  // Method to update user profile details (name, age, gender)
  void updateUserProfile({
    required String name,
    required int age,
    required String gender,
  }) {
    if (user.value != null) {
      // Update the currently logged-in user's values
      user.value!.name?.value = name;
      user.value!.age?.value = age;
      user.value!.gender?.value = gender;
    }
    if (savedUser != null) {
      // Also update the saved "database" user
      savedUser!.name?.value = name;
      savedUser!.age?.value = age;
      savedUser!.gender?.value = gender;
    }

    profileController.updateProfile(name: name, age: age, gender: gender);
  }

  // Method to update user password
  void updateUserPassword(String newPassword) {
    if (user.value != null) {
      // Update current user's password
      user.value!.password = newPassword;
    }
    if (savedUser != null) {
      // Also update saved "database" user's password
      savedUser!.password = newPassword;
    }
  }
}
