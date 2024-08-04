import 'dart:io';

import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/file_provider.dart';
import 'package:assignment/repositories/profile_repository.dart';
import 'package:assignment/repositories/request_repository.dart';
import 'package:assignment/services/auth_service.dart';
import 'package:assignment/utils/formatter.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();

  int _selectedIndex = 0;

  int get index => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  ProfileModel? _profile;

  ProfileModel? get userProfile => _profile;

  Future<void> initializeProfile(String email) async {
    // await _profileRepository.getProfile(email);
    _profile = await _profileRepository.getProfile(email);
    if (await isBanned()) {
      _profile = null;
      AuthService().signOut();
      return;
    }
    updateCreditScore();
    notifyListeners();
  }

  Future<ProfileModel> getOthersProfile(String email) =>
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

  Future<bool> updateProfile(ProfileModel profile, {File? image}) async {
    try {
      if (image != null) {
        String? imageLink;
        imageLink = await FileProvider.uploadProfileImage(image, profile.email);
        if (imageLink != null) {
          profile = profile.copyWith(imageLink: imageLink);
        }
      }
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

  Future<void> joinEvent(String eventID) async {
    List<String> eventHistory;
    if (_profile!.eventHistory == null) {
      eventHistory = [];
    } else {
      eventHistory = _profile!.eventHistory!;
    }
    eventHistory.add(eventID);
    bool status = await _profileRepository
        .updateProfile(_profile!.copyWith(eventHistory: eventHistory));
    if (status) {
      _profile = _profile!.copyWith(eventHistory: eventHistory);
      notifyListeners();
    }
  }

  Future<bool> leaveEvent(String eventID) async {
    if (_profile!.eventHistory == null) {
      return false;
    }
    List<String> eventHistory = _profile!.eventHistory!;
    eventHistory.remove(eventID);

    bool status = await _profileRepository.updateProfile(_profile!.copyWith(
        eventHistory: eventHistory, creditScore: _profile!.creditScore - 1));
    if (status) {
      _profile = _profile!.copyWith(
          eventHistory: eventHistory, creditScore: _profile!.creditScore - 1);
      notifyListeners();
    }
    return status;
  }

  // Future<bool> deductCreditScore() async {
  //   try {
  //     bool status = false;
  //     if (_profile != null) {
  //       status = await _profileRepository.updateProfile(
  //           _profile!.copyWith(creditScore: _profile!.creditScore - 1));
  //     }
  //     if (status) {
  //       _profile = _profile!.copyWith(creditScore: _profile!.creditScore - 1);
  //       notifyListeners();
  //     }
  //     return true;
  //   } on Exception catch (_) {
  //     return false;
  //   }
  // }

  Future<void> updateCreditScore() async {
    if (_profile != null) {
      if (_profile!.creditScore == 100) {
        return;
      }
      if (_profile!.lastLoggedInDate.isBefore(DateTime.now())) {
        await _profileRepository.updateProfile(_profile!.copyWith(
            creditScore: _profile!.creditScore + 1,
            lastLoggedInDate: formatDateTimeToDate(DateTime.now())));
      }
    }
  }

  Future<bool> isBanned() async {
    if (_profile != null) {
      if (_profile!.status == AccountStatus.banned) {
        if (await RequestRepository().getBannedStatus(_profile!.email)) {
          return true;
        } else {
          _profileRepository
              .updateProfile(_profile!.copyWith(status: AccountStatus.active));
        }
      }
    }
    return false;
  }

  Future<String?> userExist(String email) async {
    return await _profileRepository.checkIfUserExist(email);
  }

}
