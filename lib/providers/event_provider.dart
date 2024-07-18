import 'dart:io';

import 'package:assignment/models/event_model.dart';
import 'package:assignment/providers/file_provider.dart';
import 'package:assignment/repositories/event_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  Future<bool> organizeEvent(EventModel event, File image, List<File?> materials) async {

    try {
String id = await _eventRepository.addEvent(event);
    String? imageLink = await FileProvider.uploadEventImage(image, id);
    
    List<String>? eventMaterials;
    if (materials.isNotEmpty) {
      for (File? file in materials) {
        if (file != null) {
          //upload file and get the link
        } else {
          break;
        }  
      }
    } else {
      eventMaterials = null;
    }
    if (imageLink != null) {
      event.copyWith(materials: eventMaterials, imageLink: imageLink);
      await _eventRepository.updateEvent(event);
      return true;
    }
    return false;
    } catch (e) {
      return false;
    }
    

  }

  void sortOrderList() {
    
  }

  // Stream<List<EventModel>> getEventsByStatus(EventStatus status) => _eventRepository.getEventsByStatus(status);
}
