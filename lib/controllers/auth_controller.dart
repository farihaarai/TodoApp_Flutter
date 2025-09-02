import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newtodoapp/controllers/base_api_controller.dart';
import '../models/user.dart';
import 'profile_controller.dart';

class AuthController extends BaseApiController {
  final Rx<User?> user = Rx<User?>(null);
  final RxString token = ''.obs; // JWT token

  ProfileController profileController = Get.put(ProfileController());

  /// Step 1: Login
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    print("Login response: ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token.value = data["jwtToken"];
      print("Got JWT: ${token.value}");
      return await fetchUserDetails();
    } else {
      print("Login failed: ${response.statusCode}");
      return false;
    }
  }

  /// Step 2: Fetch user details with JWT
  Future<bool> fetchUserDetails() async {
    final url = Uri.parse('$baseUrl/user');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      },
    );

    print("User details response: ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final fetchedUser = User.fromJson(data);

      user.value = fetchedUser;

      // sync to profile controller for UI
      profileController.name.value = fetchedUser.name;
      profileController.age.value = fetchedUser.age;
      profileController.gender.value = fetchedUser.gender;
      return true;
    }
    return false;
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String gender,
    required int age,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/registerUserGet').replace(
      queryParameters: {
        'name': name,
        'email': email,
        'gender': gender,
        'age': age.toString(),
        'password': password,
      },
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token.value = data["jwtToken"];
      print("Got JWT: ${token.value}");
      return await fetchUserDetails();
    } else {
      print("Signup failed: ${response.statusCode}");
      return false;
    }
  }

  /// Logout
  void logout() {
    user.value = null;
    token.value = '';
    profileController.clearProfile();
  }

  /// Update Profile
  // void updateUserProfile({
  //   required String name,
  //   required int age,
  //   required String gender,
  // }) {
  //   if (user.value != null) {
  //     user.value = User(
  //       email: user.value!.email,
  //       password: user.value!.password,
  //       name: name,
  //       age: age,
  //       gender: gender,
  //     );
  //   }
  //   profileController.updateProfile(name: name, age: age, gender: gender);
  // }

  Future<bool> updateUserProfile({
    required String name,
    required int age,
    required String gender,
  }) async {
    final url = Uri.parse('$baseUrl/user');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
        body: jsonEncode({"name": name, "age": age, "gender": gender}),
      );

      print("Update profile response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // update user in AuthController
        if (user.value != null) {
          user.value = User(
            email: user.value!.email,
            password: user.value!.password,
            name: name,
            age: age,
            gender: gender,
          );
        }

        // sync values to ProfileController for UI
        profileController.name.value = name;
        profileController.age.value = age;
        profileController.gender.value = gender;

        return true;
      } else {
        print("Failed to update user: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }

  Future<bool> updateUserPassword({
    required currentPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse('$baseUrl/user/password');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      },
      body: jsonEncode({
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      }),
    );
    print("Update password response: ${response.statusCode} ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (user.value != null) {
        user.value = User(
          email: user.value!.email,
          password: newPassword,
          name: user.value!.name,
          age: user.value!.age,
          gender: user.value!.gender,
        );
      }
      return true;
    } else {
      return false;
    }
  }
}
 /// Signup
  // void signup({
  //   required String name,
  //   required String email,
  //   required int age,
  //   required String password,
  //   required String gender,
  // }) {
  //   final newUser = User(
  //     email: email,
  //     password: password,
  //     name: name,
  //     age: age,
  //     gender: gender,
  //   );

  //   user.value = newUser;
  //   profileController.updateProfile(name: name, age: age, gender: gender);
  // }
  /// Signup (beginner-friendly way using JSON)
  // Future<bool> signup({
  //   required String name,
  //   required String email,
  //   required String gender,
  //   required int age,
  //   required String password,
  // }) async {
  //   final url = Uri.parse('$baseUrl/registerUser');

  //   final response = await http.post(
  //     url,
  //     headers: {"Content-Type": "application/x-www-form-urlencoded"},
  //     body: {
  //       "name": name,
  //       "email": email,
  //       "gender": gender,
  //       "age": age.toString(),
  //       "password": password,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     token.value = data["jwtToken"];
  //     print("Got JWT: ${token.value}");
  //     return await fetchUserDetails();
  //   } else {
  //     print("Signup failed: ${response.statusCode}");
  //     return false;
  //   }
  // }
  // Future<bool> signup({
  //   required String name,
  //   required String email,
  //   required String gender,
  //   required int age,
  //   required String password,
  // }) async {
  //   final url = Uri.parse('$baseUrl/registerUser');
  //   final request = http.MultipartRequest('POST', url)
  //     ..fields['name'] = name
  //     ..fields['email'] = email
  //     ..fields['gender'] = gender
  //     ..fields['age'] = age.toString()
  //     ..fields['password'] = password;

  //   final http.StreamedResponse sr = await request.send();
  //   http.Response response = await http.Response.fromStream(sr);

  //   if (response.statusCode == 200) {
  //     print("Success");
  //     String body = response.body;
  //     final data = jsonDecode(body);
  //     token.value = data["jwtToken"];
  //     print("Got JWT: ${token.value}");
  //     return await fetchUserDetails();
  //     // return false;
  //   } else {
  //     print("Signup failed: ${response.statusCode}");
  //     return false;
  //   }
  // }
  