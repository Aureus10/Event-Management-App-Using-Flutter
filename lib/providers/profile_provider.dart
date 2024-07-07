import 'package:assignment/models/profile_model.dart';
import 'package:assignment/repositories/profile_repository.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  late ProfileModel profile;

  ProfileModel get userProfile => profile;

  Future<void> initializeProfile(String email) async {
    profile = await ProfileRepository.getProfile(email);
    notifyListeners();
  }

  Future<void> getOthersProfile(String email) =>
      ProfileRepository.getProfile(email);

  Future<bool> addProfile(ProfileModel profile) async {
    try {
      bool status = await ProfileRepository.addProfile(profile);
      if (status) {
        this.profile = profile;
        notifyListeners();
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> setProfile(ProfileModel profile) async {
    try {
      bool status = await ProfileRepository.setProfile(profile);
      if (status) {
        this.profile = profile;
        notifyListeners();
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  // Future<bool> deleteProfile(String email) {
  //   return
  // }
  
}
