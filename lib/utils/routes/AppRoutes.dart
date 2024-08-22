// AppRoutes.dart
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:karat_habit_tracker_app/view/about_screen.dart';
import 'package:karat_habit_tracker_app/view/challenge_screen/challenge_screen.dart';
import 'package:karat_habit_tracker_app/view/faq_screen.dart';
import '../../view/components/Sidebar/binding.dart';
import '../../view/habit_screen/habit_screen.dart';
import '../../view/login_screen/login_screen.dart';
import '../../view/notif_screen.dart';
import '../../view/onboarding_screens/onboarding_screen.dart';
import '../../view/profile_screen/profile.dart';
import '../../view/profile_screen/profile_binding.dart';
import '../../view/setting_screen/setting_screen.dart';
import '../../view/signup_screen/signup_screen.dart';
import '../../view/statistics_screen/statistics_screen.dart';
import '../../view/track_screen/track_screen.dart';
import 'RouteNames.dart';
export 'package:get/get.dart';

final List<GetPage> routes = [
  GetPage(name: AppRouteName.onBoardingScreen, page: () => const onBoardingScreen()),
  GetPage(name:AppRouteName.loginScreen, page: () => const LoginPage()),
  GetPage(name:AppRouteName.signUpScreen, page: () => SignUpPage()),
  GetPage(name:AppRouteName.habitScreen, page: () => HabitPage(), binding: SideBarBinding()),
  GetPage(name: AppRouteName.profileScreen, page: () => const ProfilePage(), binding: UserBinding(),),
  GetPage(name: AppRouteName.settingScreen, page: () => const SettingsPage(),binding: UserBinding()),
  GetPage(name:AppRouteName.trackScreen, page: () => TrackPage(), binding: SideBarBinding()),
  GetPage(name:AppRouteName.aboutScreen, page: () => const AboutPage()),
  GetPage(name:AppRouteName.faqScreen, page: () => const FAQPage()),
  GetPage(name:AppRouteName.challengeScreen, page: () => ChallengePage(), binding: SideBarBinding()),
  GetPage(name:AppRouteName.statisticsScreen, page: () => StatisticsPage(), binding: SideBarBinding()),
  GetPage(name:AppRouteName.notifsScreen, page: () => NotificationPage(),),

];


