import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxString name = "".obs;
  RxInt age = 0.obs;
  RxString gender = "f".obs;

  void updateProfile({
    required String name,
    required int age,
    required String gender,
  }) {
    this.name.value = name;
    this.age.value = age;
    this.gender.value = gender;
  }
}
