import 'package:get/get.dart';

import '../models/user_model.dart';
import '../repo/authentication_repository.dart';
import '../repo/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  // Get User Email and pass to User Repository to fetch User Info
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue...");
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    return await _userRepo.allUser();
  }
}
