import 'package:assignment/models/profile_model.dart';
import 'package:assignment/services/repository.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  
  late ProfileModel profile;

  Future<void> getProfile(String email) async {
    profile = await ProfileRepository.getProfile(email);
  }

  Future<bool> addProfile(ProfileModel profile) {
    return ProfileRepository.addProfile(profile);
  }

  Future<bool> setProfile({UserType? type,
    int? age,
    Gender? gender,
    String? email,
    String? contact,
    List<String>? eventHistory,
    int? creditScore,
    String? imageLink,}) {
      profile = profile.copyWith();
      ProfileRepository.setProfile(profile);
      return ProfileRepository.setProfile(profile);
    }

  //   profile = profile.copyWith(changes)


  //   return ProfileRepository.setProfile(profile);
  // }

  // Future<bool> deleteProfile(String email) {
  //   return 
  // }

}

class EventProvider extends ChangeNotifier {

}