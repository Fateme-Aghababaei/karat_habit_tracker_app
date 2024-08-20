import 'package:get/get.dart';
import '../model/entity/challenge_model.dart';
import '../model/repositories/challenge_repository.dart';
import '../view/components/Sidebar/SideBarController.dart';

class ChallengeViewModel extends GetxController {
  final ChallengeRepository _challengeRepository = ChallengeRepository();
  final RxBool isLoading = false.obs;
  var challenges = <Challenge>[].obs;
  var participatedChallenges = <Challenge>[].obs;
  final SideBarController sideBarController = Get.find();
  var selectedChallenge = Rxn<Challenge>();
  final RxBool fetchError = false.obs;


  @override
  void onInit() {
    super.onInit();
    _loadChallenge();
  }

  Future<void> _loadChallenge() async {
   await loadChallenges();
    await loadParticipatedChallenges();

  }

  // Load active challenges
  Future<void> loadChallenges() async {
    isLoading.value = true;
    try {
      var loadedChallenges = await _challengeRepository.getActiveChallenges();
      if (loadedChallenges != null) {
        challenges.assignAll(loadedChallenges);
      }
    } catch (e) {
      fetchError(true);
      print("Error loading challenges: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Load participated challenges
  Future<void> loadParticipatedChallenges() async {
    isLoading.value = true;
    try {
      var loadedChallenges = await _challengeRepository.getParticipatedChallenges();
      if (loadedChallenges != null) {
        participatedChallenges.assignAll(loadedChallenges);
      }
    } catch (e) {
      fetchError(true);
      print("Error loading participated challenges: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Add new challenge
  Future<void> addChallenge({
    required String name,
    required String description,
    required String startDate,
    required String endDate,
    String? photo,
  }) async {
    try {
      var newChallenge = await _challengeRepository.addChallenge(
        name: name,
        description: description,
        startDate: startDate,
        endDate: endDate,
        photo: photo,
      );
      if (newChallenge != null) {
        participatedChallenges.insert(0, newChallenge);

      }
    } catch (e) {
      print("Error adding challenge: $e");
    }
  }

  // Edit existing challenge
  Future<void> editChallenge({
    required int id,
    required String name,
    required String description,
    required String startDate,
    required String endDate,
    String? photo,
  }) async {
    try {
      var updatedChallenge = await _challengeRepository.editChallenge(
        id: id,
        name: name,
        description: description,
        startDate: startDate,
        endDate: endDate,
        photo: photo,
      );
      if (updatedChallenge != null) {
        int index = participatedChallenges.indexWhere((challenge) => challenge.id == id);
        if (index != -1) {
          participatedChallenges[index] = updatedChallenge;
          participatedChallenges.refresh();
        }
      }
    } catch (e) {
      print("Error editing challenge: $e");
    }
  }

  Future<void> appendHabitToChallenge({
    required int challengeId,
    required int habitId,

  }) async {
    try {
      var updatedChallenge = await _challengeRepository.appendHabit(
        challengeId: challengeId,
        habitId: habitId,
      );

      if (updatedChallenge != null) {
        // بروز رسانی چالش‌ها
        int index = participatedChallenges.indexWhere((challenge) => challenge.id == challengeId);
        if (index != -1) {
          participatedChallenges[index] = updatedChallenge;
          participatedChallenges.refresh();
        }
      else{print("Error appending habit to challenge");}
      }
    } catch (e) {
      print("Error appending habit to challenge: $e");
    }
  }

  // Remove habit from challenge
  Future<void> removeHabitFromChallenge({
    required int challengeId,
    required int habitId,
  }) async {
    try {
      var updatedChallenge = await _challengeRepository.removeHabit(
        challengeId: challengeId,
        habitId: habitId,
      );
      if (updatedChallenge != null) {
        // بروز رسانی چالش‌ها
        int index = participatedChallenges.indexWhere((challenge) => challenge.id == challengeId);
        if (index != -1) {
          participatedChallenges[index] = updatedChallenge;
          participatedChallenges.refresh();
        }
        else{print("Error removing habit from challenge");}
      }
    } catch (e) {
      print("Error removing habit from challenge: $e");
    }
  }

  Future<void> participateInChallenge({
    required int challengeId,
  }) async {
    try {
      var participatedChallenge = await _challengeRepository.participateInChallenge(
        challengeId: challengeId,
      );
      if (participatedChallenge != null) {
        // افزودن چالش جدید به لیست شرکت کرده‌ها
        participatedChallenges.insert(0, participatedChallenge);
        participatedChallenges.refresh();
        int index = challenges.indexWhere((challenge) => challenge.id == participatedChallenge.id);
        if (index != -1) {
          // جایگزینی چالش
          challenges[index] = participatedChallenge;
        }
        challenges.refresh();

      }
      else{print("Error participating in challenge");}

    } catch (e) {
     rethrow;
    }
  }

  Future<void> getChallengeByIdOrCode({
    int? id,
    String? code,
  }) async {
    isLoading.value = true;
    try {
      var challenge = await _challengeRepository.getChallengeByIdOrCode(
        id: id,
        code: code,
      );
      if (challenge != null) {
        selectedChallenge.value = challenge;
      }
      else{print("Error fetching challenge");}
    } catch (e) {
      print("Error fetching challenge: $e");

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteChallenge(int id) async {
    try {
      final response = await _challengeRepository.deleteChallenge(id);

      participatedChallenges.removeWhere((challenge) => challenge.id == id);
      participatedChallenges.refresh();

    } catch (e) {
      print("Failed to delete challenge: $e");
    }
  }






}
