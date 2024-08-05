import 'package:get/get.dart';
import '../model/entity/user_model.dart';
import '../model/repositories/user_repository.dart';

class UserViewModel extends GetxController {
  final UserRepository _userRepository = UserRepository();

  // User Profile
  var userProfile = UserModel().obs;
  var isLoadingUserProfile = false.obs;
  var isLoadingFollowers = false.obs;
  var followers = <Follow>[].obs;
  var followings = <Follow>[].obs;

  final String? username;

  UserViewModel(this.username);

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    await fetchUserProfile(username);
    await fetchFollowerFollowing(username);
  }
  // Get user profile
  Future<void> fetchUserProfile(String? username) async {
    try {
      isLoadingUserProfile(true);
      UserModel? profile = await _userRepository.getUserProfile(username);
      userProfile(profile);
    } catch (e) {
      print("Error fetching user profile: $e");
    } finally {
      isLoadingUserProfile(false);
    }
  }

  // Get followers and followings
  Future<void> fetchFollowerFollowing(String? username) async {
    try {
      isLoadingFollowers(true);
      List<List<Follow>>? result = await _userRepository.getFollowerFollowing(username);
      followers(result?[0]);
      followings(result?[1]);
    } catch (e) {
      print("Error fetching follower/following: $e");
    } finally {
      isLoadingFollowers(false);
    }
  }

  // Follow a user
  Future<void> followUser(String username) async {
    try {
      await _userRepository.followUser(username);
      await fetchFollowerFollowing(username);
    } catch (e) {
      print("Error following user: $e");
    }
  }

  // Unfollow a user
  Future<void> unfollowUser(String username) async {
    try {
      await _userRepository.unfollowUser(username);
      await fetchFollowerFollowing(username);
    } catch (e) {
      print("Error unfollowing user: $e");
    }
  }
}
