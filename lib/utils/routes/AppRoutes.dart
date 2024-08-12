// AppRoutes.dart
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/habit_screen/habit_screen.dart';
import '../../view/login_screen/login_screen.dart';
import '../../view/onboarding_screens/onboarding_screen.dart';
import '../../view/profile_screen/profile.dart';
import '../../view/profile_screen/profile_binding.dart';
import '../../view/setting_screen/setting_screen.dart';
import '../../view/signup_screen/signup_screen.dart';
import 'RouteNames.dart';
export 'package:get/get.dart';

final List<GetPage> routes = [
  GetPage(name: AppRouteName.onBoardingScreen, page: () => const onBoardingScreen()),
  GetPage(name:AppRouteName.loginScreen, page: () => const LoginPage()),
  GetPage(name:AppRouteName.signUpScreen, page: () => SignUpPage()),
  GetPage(name:AppRouteName.habitScreen, page: () => HabitPage()),
  GetPage(name: AppRouteName.profileScreen, page: () => const ProfilePage(), binding: UserBinding(),),
  GetPage(name: AppRouteName.settingScreen, page: () => const SettingsPage(),binding: UserBinding()),


];


