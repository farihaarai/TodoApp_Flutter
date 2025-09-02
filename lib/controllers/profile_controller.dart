import 'package:get/get.dart';
import 'package:newtodoapp/controllers/base_api_controller.dart';

class ProfileController extends BaseApiController {
  final RxString name = "".obs;
  final RxInt age = 0.obs;
  final RxString gender = "f".obs;

  void clearProfile() {
    name.value = "";
    age.value = 0;
    gender.value = "f";
  }
}
