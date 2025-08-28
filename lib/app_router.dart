import 'package:get/get.dart';
import 'package:newtodoapp/screens/change_password_screen.dart';
import 'package:newtodoapp/screens/edit_profile_screen.dart';
import 'package:newtodoapp/screens/edit_todo_screen.dart';
import 'package:newtodoapp/screens/login_screen.dart';
import 'package:newtodoapp/screens/signup_screen.dart';
import 'package:newtodoapp/screens/todo_screen.dart';

class AppRouter {
  static String loginscreen = '/Login';
  static String signupscreen = '/Signup';
  static String todoscreen = '/Todos';
  static String edittodoscreen = '/todo-edit';
  static String editprofilescreen = '/profile-edit';
  static String changepasswordscreen = '/change-password';

  // static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  //   log(settings.toString());
  //   if (settings.name == loginscreen) {
  //     return GetPageRoute(page: () => LoginScreen());
  //   } else if (settings.name == signupscreen) {
  //     return GetPageRoute(page: () => SignupScreen());
  //   }
  //   return null;
  // }

  static List<GetPage> pages() {
    return [
      GetPage(name: loginscreen, page: () => LoginScreen()),
      GetPage(name: signupscreen, page: () => SignupScreen()),
      GetPage(name: todoscreen, page: () => TodoScreen()),
      GetPage(name: edittodoscreen, page: () => EditTodoScreen()),
      GetPage(name: editprofilescreen, page: () => EditProfileScreen()),
      GetPage(name: changepasswordscreen, page: () => ChangePasswordScreen()),
    ];
  }
}
