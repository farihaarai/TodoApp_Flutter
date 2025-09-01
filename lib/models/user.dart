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
    String email = json['email'] ?? '';
    String password = json['password'] ?? '';
    String name = json['name'] ?? '';
    int age = json['age'] is int
        ? json['age']
        : int.tryParse(json['age']?.toString() ?? '0') ?? 0;
    String gender = json['gender'] ?? '';

    return User(
      email: email,
      password: password,
      name: name,
      age: age,
      gender: gender,
    );
  }
}
