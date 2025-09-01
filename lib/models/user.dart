// import 'package:get/get.dart';

class User {
  final String email;
  final String password;
  final String name;
  final int age;
  final String gender;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    String email = (json['email']) as String;
    String password = (json['password']) as String;
    String name = (json['name']) as String;
    int age = json['age'] as int;
    String gender = (json['gender']) as String;

    return User(
      email: email,
      password: password,
      name: name,
      age: age,
      gender: gender,
    );
  }
}
