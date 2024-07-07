
import 'package:assignment/models/event_model.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  
  final List<EventModel> _eventList = [];

  List<EventModel> get events => _eventList;

  



}