import 'package:get/get.dart';

class User {
  String email;
  String password;

  RxString? name;
  RxInt? age;
  RxString? gender;

  User({
    required this.email,
    required this.password,
    this.name,
    this.age,
    this.gender,
  });

  User copyWith({String? name, int? age, String? gender}) {
    return User(
      email: email,
      password: password,
      name: name != null ? name.obs : this.name,
      age: age != null ? age.obs : this.age,
      gender: gender != null ? gender.obs : this.gender,
    );
  }
}
