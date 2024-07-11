
import 'package:assignment/models/event_model.dart';
import 'package:assignment/repositories/event_repository.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  
  final EventRepository _eventRepository = EventRepository();

  List<EventModel> _eventList = [];

  List<EventModel> get events => _eventList;

  

  Stream<List<EventModel>> getEventsByStatus(EventStatus status) => _eventRepository.getEventsByStatus(status);





}