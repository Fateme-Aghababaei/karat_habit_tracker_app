import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/entity/challenge_model.dart';
import '../model/repositories/challenge_repository.dart';
import '../view/components/Sidebar/SideBarController.dart';

class ChallengeViewModel extends GetxController {
  final ChallengeRepository _challengeRepository = ChallengeRepository();
  final RxBool isLoading = false.obs;
  final GetStorage _storage = GetStorage();
  var challenges = <Challenge>[].obs;
  var participatedChallenges = <Challenge>[].obs;
  final SideBarController sideBarController = Get.find();
  var selectedChallenge = Rxn<Challenge>();


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
        _saveChallengesToStorage(loadedChallenges.take(5).toList());
      } else {
        _loadChallengesFromStorage();
      }
    } catch (e) {
      print("Error loading challenges: $e");
      _loadChallengesFromStorage();
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
        _saveParticipatedChallengesToStorage(loadedChallenges.take(4).toList());
      } else {
        _loadParticipatedChallengesFromStorage();
      }
    } catch (e) {
      print("Error loading participated challenges: $e");
      _loadParticipatedChallengesFromStorage();
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

        // اضافه کردن چالش به لیست چالش‌های شرکت‌کرده‌شده
        addParticipatedChallenge(newChallenge);
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
        // ویرایش چالش در لیست چالش‌های شرکت‌کرده‌شده
        editParticipatedChallenge(updatedChallenge);
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
          editParticipatedChallenge(updatedChallenge);
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
          editParticipatedChallenge(updatedChallenge);
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

        // اطمینان از اینکه فقط 4 چالش در حافظه ذخیره می‌شود
        if (participatedChallenges.length > 4) {
          participatedChallenges.removeLast();
        }
        _saveParticipatedChallengesToStorage(participatedChallenges);
      }
      else{print("Error participating in challenge");}

    } catch (e) {
      print("Error participating in challenge: $e");
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

      _saveParticipatedChallengesToStorage(participatedChallenges);
    } catch (e) {
      print("Failed to delete challenge: $e");
    }
  }



  // Private methods to save and load data from GetStorage

  void _saveChallengesToStorage(List<Challenge> challenges) {
    List<Map<String, dynamic>> challengeList = challenges.map((challenge) => challenge.toJson()).toList();
    _storage.write('activeChallenges', challengeList);
  }

  void _loadChallengesFromStorage() {
    var storedChallenges = _storage.read<List>('activeChallenges');
    if (storedChallenges != null) {
      challenges.assignAll(storedChallenges.map((challenge) => Challenge.fromJson(challenge)).toList());
    }
  }

  void _saveParticipatedChallengesToStorage(List<Challenge> challenges) {
    List<Map<String, dynamic>> challengeList = challenges.map((challenge) => challenge.toJson()).toList();
    if (challengeList.length > 4) {
      challengeList = challengeList.sublist(0, 4);
    }
    _storage.write('participatedChallenges', challengeList);
  }

  void _loadParticipatedChallengesFromStorage() {
    var storedChallenges = _storage.read<List>('participatedChallenges');
    if (storedChallenges != null) {
      participatedChallenges.assignAll(storedChallenges.map((challenge) => Challenge.fromJson(challenge)).toList());
    }
  }

  void addParticipatedChallenge(Challenge challenge) {
    var storedChallenges = _storage.read<List>('participatedChallenges');
    List<Challenge> challenges = storedChallenges != null
        ? storedChallenges.map((challenge) => Challenge.fromJson(challenge)).toList()
        : [];
    // اگر چالش جدید از قبل وجود داشته باشد، آن را حذف می‌کنیم
    challenges.removeWhere((c) => c.id == challenge.id);
    // چالش جدید را به ابتدای لیست اضافه می‌کنیم
    challenges.insert(0, challenge);
    _saveParticipatedChallengesToStorage(challenges);
  }

  void editParticipatedChallenge(Challenge challenge) {
    var storedChallenges = _storage.read<List>('participatedChallenges');
    List<Challenge> challenges = storedChallenges != null
        ? storedChallenges.map((challenge) => Challenge.fromJson(challenge)).toList()
        : [];

    int index = challenges.indexWhere((c) => c.id == challenge.id);
    if (index != -1) {
      challenges[index] = challenge;
      _saveParticipatedChallengesToStorage(challenges);
    }
  }

  // void deleteParticipatedChallenge(int challengeId) {
  //   var storedChallenges = _storage.read<List>('participatedChallenges');
  //   List<Challenge> challenges = storedChallenges != null
  //       ? storedChallenges.map((challenge) => Challenge.fromJson(challenge)).toList()
  //       : [];
  //
  //   challenges.removeWhere((c) => c.id == challengeId);
  //   _saveParticipatedChallengesToStorage(challenges);
  // }
}
