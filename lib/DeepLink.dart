import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/view/challenge_screen/SpecificChallengePage.dart';
import 'package:karat_habit_tracker_app/viewmodel/challenge_viewmodel.dart';

import 'model/constant.dart';

class AppLinksDeepLink {
  AppLinksDeepLink._privateConstructor() {
    _appLinks = AppLinks();  // Initialize _appLinks in the constructor
  }

  static final AppLinksDeepLink _instance = AppLinksDeepLink._privateConstructor();

  static AppLinksDeepLink get instance => _instance;

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  void onInit() {
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialLink();
    if (appLink != null) {
      var uri = Uri.parse(appLink.toString());
      print(' here you can redirect from url as per your need ');
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uriValue) async {
      final String? code = uriValue.queryParameters['code'];
      final box = GetStorage();
      final token = box.read('auth_token');
      dio.options.headers["Authorization"] = "Token $token";
      if (code != null) {
        final challengeViewModel = Get.put(ChallengeViewModel());
        await challengeViewModel.getChallengeByIdOrCode(code: code);

        if (challengeViewModel.selectedChallenge.value != null) {
          Get.to(() => SpecificChallengePage(
            challengeViewModel: challengeViewModel,
            challenge:challengeViewModel.selectedChallenge ,
            isFromMyChallenges: false,
          ));
        } else {
          Get.snackbar('Error', 'Challenge not found or failed to fetch.');
        }
      } else {
        Get.snackbar('Error', 'Invalid invitation link.');
      }

    }, onError: (err) {
      debugPrint('====>>> error : $err');
    }, onDone: () {
      _linkSubscription?.cancel();
    });
  }
}
