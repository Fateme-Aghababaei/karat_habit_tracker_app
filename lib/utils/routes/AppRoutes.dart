// AppRoutes.dart
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/login_screen/login_screen.dart';
import '../../view/onboarding_screens/onboarding_screen.dart';
import '../../view/signup_screen/signup_screen.dart';
import 'RouteNames.dart';
export 'package:get/get.dart';

final List<GetPage> routes = [
  GetPage(name: AppRouteName.onBoardingScreen, page: () => const onBoardingScreen()),
  GetPage(name:AppRouteName.loginScreen, page: () => const LoginPage()),
  GetPage(name:AppRouteName.signUpScreen, page: () => SignUpPage()),
];


