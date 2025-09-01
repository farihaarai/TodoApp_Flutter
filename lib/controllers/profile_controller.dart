import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString name = "".obs;
  final RxInt age = 0.obs;
  final RxString gender = "f".obs;

  void updateProfile({
    required String name,
    required int age,
    required String gender,
  }) {
    this.name.value = name;
    this.age.value = age;
    this.gender.value = gender;
  }

  void clearProfile() {
    name.value = "";
    age.value = 0;
    gender.value = "f";
  }
}
