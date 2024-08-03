import 'dart:io';

import 'package:assignment/models/event_model.dart';
import 'package:assignment/providers/file_provider.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/repositories/event_repository.dart';
import 'package:assignment/services/auth_service.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();

  List<EventModel> _eventList = [];

  List<EventModel> get events => _eventList;

  Future<void> getEvents() async {
    _eventRepository.getAllEvents().listen((snapshot) {
      _eventList = snapshot.docs
          .map((doc) => EventModel.fromMap(doc.id, doc.data()))
          .toList();
      notifyListeners();
    });
    updateStatus();
  }

  Future<String?> organizeEvent(
      EventModel event, File image, Map<String, File> materials) async {
    try {
      debugPrint('test4');

      String id = await _eventRepository.addEvent(event);
      debugPrint(id);
      String? imageLink = await FileProvider.uploadEventImage(image, id);

      Map<String, String> eventMaterials = {};
      if (materials.isNotEmpty) {
        for (String fileName in materials.keys) {
          String? link = await FileProvider.uploadEventFile(
              materials[fileName]!, id, fileName);
          if (link != null) {
            eventMaterials[fileName] = link;
          }
        }
      }

      if (imageLink != null) {
        await _eventRepository.updateEvent(event.copyWith(
            id: id, materials: eventMaterials, imageLink: imageLink));
        return id;
      }

      return null;
    } catch (e) {
      debugPrint('test1');
      return null;
    }
  }

  Future<void> updateStatus() async {
    bool changed = false;
    for (EventModel event in _eventList) {
      for (Map<DateTime, DateTime> datetime in event.datetime) {
        if (event.status == EventStatus.cancelled ||
            event.status == EventStatus.completed) {
          break;
        }
        if (datetime.values.last.isBefore(DateTime.now())) {
          _eventRepository
              .updateEvent(event.copyWith(status: EventStatus.completed));
          changed = true;
        } else if (datetime.keys.first.isBefore(DateTime.now()) &&
            datetime.values.last.isAfter(DateTime.now())) {
          _eventRepository
              .updateEvent(event.copyWith(status: EventStatus.ongoing));
          changed = true;
        }
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

  EventModel getEvent(String id) {
    return events.firstWhere((event) => event.id == id);
  }

  Future<void> joinEvent(EventModel event) async {
    String? email = AuthService().userEmail;

    if (email != null) {
      List<String>? participants = event.participants;
      if (participants != null) {
        participants.add(email);
      } else {
        participants = [email];
      }
      await _eventRepository
          .updateEvent(event.copyWith(participants: participants));
    }
  }

  Future<void> leaveEvent(EventModel event) async {
    String? email = AuthService().userEmail;

    if (email != null) {
      List<String>? participants = event.participants;
      if (participants != null) {
        participants.remove(email);
      }
      if (await ProfileProvider().deductCreditScore()) {
        await _eventRepository
            .updateEvent(event.copyWith(participants: participants));
      }
    }
  }

  Future<void> editEvent(EventModel event) async {}

  // Stream<List<EventModel>> getEventsByStatus(EventStatus status) => _eventRepository.getEventsByStatus(status);
}
