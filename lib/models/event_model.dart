import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum EventType {
  exhibition,
  tour,
  concert,
  games,
  workshops,
  festival,
  competition,
  conference,
  hackathon,
  webinar,
  seminar,
  fundraising,
  booth,
}

enum EventStatus {
  scheduled,
  ongoing,
  completed,
  cancelled,
  postponed,
}

const Map<EventStatus, Color> eventStatusColor = {
  EventStatus.cancelled: Color.fromARGB(255, 255, 66, 66),
  EventStatus.completed: Color.fromARGB(255, 199, 194, 194),
  EventStatus.ongoing: Color.fromARGB(255, 120, 255, 125),
  EventStatus.postponed: Colors.amber,
  EventStatus.scheduled: Color.fromARGB(255, 113, 191, 255)
};

class EventModel {
  final String? id;
  final String organizerEmail;
  final String title;
  final String description;
  final String venue;
  final double fees;
  final String contact;
  final EventType type;
  final List<Map<DateTime, DateTime>> datetime;
  final int capacity;
  final String imageLink;
  final bool isAnonymous;
  final EventStatus status;
  final List<String>? materials;
  final List<String>? participants;

  EventModel({
    required this.id,
    required this.organizerEmail,
    required this.title,
    required this.description,
    required this.venue,
    required this.fees,
    required this.contact,
    required this.type,
    required this.datetime,
    required this.capacity,
    required this.imageLink,
    required this.isAnonymous,
    required this.status,
    this.materials,
    this.participants,
  });

  factory EventModel.fromMap(String id, Map<String, dynamic> map) => EventModel(
        id: id,
        organizerEmail: map['organizerEmail'],
        title: map['title'],
        description: map['description'],
        venue: map['venue'],
        fees: double.parse(map['fees']),
        contact: map['contact'],
        type: EventType.values[map['type']],
        datetime: (map['Datetime'] as Map<String, dynamic>).entries.map((entry) {
    return {DateTime.parse(entry.key): (entry.value as Timestamp).toDate()};
  }).toList(),
        capacity: int.parse(map['capacity']),
        imageLink: map['imageLink'],
        isAnonymous: bool.parse(map['isAnonymous']),
        status: EventStatus.values[map['status']],
        materials: List<String>.from(map['materials']),
        participants: List<String>.from(map['participants']),
      );

  Map<String, dynamic> toMap() => {
        'organizer': organizerEmail,
        'title': title,
        'description': description,
        'venue': venue,
        'fees': fees,
        'contact': contact,
        'type': type,
        'datetime': {for (var entry in datetime) entry.keys.first.toIso8601String(): Timestamp.fromDate(entry.values.first)},
        'capacity': capacity,
        'imageLink': imageLink,
        'isAnonymous': isAnonymous,
        'status': status,
        'materials': materials,
        'participants': participants,
      };

  EventModel copyWith({
    String? organizerEmail,
    String? title,
    String? description,
    String? venue,
    double? fees,
    String? contact,
    EventType? type,
    List<Map<DateTime, DateTime>>? datetime,
    int? capacity,
    String? imageLink,
    bool? isAnonymous,
    EventStatus? status,
    List<String>? materials,
    List<String>? participants,
  }) {
    return EventModel(
      id: id,
      organizerEmail: organizerEmail ?? this.organizerEmail,
      title: title ?? this.title,
      description: description ?? this.description,
      venue: venue ?? this.venue,
      fees: fees ?? this.fees,
      contact: contact ?? this.contact,
      type: type ?? this.type,
      datetime: datetime ?? this.datetime,
      capacity: capacity ?? this.capacity,
      imageLink: imageLink ?? this.imageLink,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      status: status ?? this.status,
      materials: materials ?? this.materials ?? [],
      participants: participants ?? this.participants ?? [],
    );
  }
}
