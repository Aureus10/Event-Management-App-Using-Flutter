import 'package:assignment/models/profile_model.dart';
import 'package:assignment/repositories/profile_repository.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileModel? _profile;

  ProfileModel? get userProfile => _profile;

  Future<void> initializeProfile(String email) async {
    _profile = await _profileRepository.getProfile(email);
    notifyListeners();
  }

  Future<void> getOthersProfile(String email) =>
      _profileRepository.getProfile(email);

  Future<bool> addProfile(ProfileModel profile) async {
    try {
      bool status = await _profileRepository.addProfile(profile);
      if (status) {
        _profile = profile;
        notifyListeners();
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<bool> updateProfile(ProfileModel profile) async {
    try {
      bool status = await _profileRepository.updateProfile(profile);
      if (status) {
        _profile = profile;
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
