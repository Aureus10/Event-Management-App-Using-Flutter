import 'package:assignment/models/profile_model.dart';

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

class Event {

  final Profile organizer;
  final String title;
  final String description;
  final String venue;
  final double fees;
  final String contact;
  final EventType type;
  final List<DateTime> datetime;
  final String capacity;
  final String imageLink;
  final bool isAnonymous;
  List<String>? materials;
  List<Profile>? participants;

  Event({
    required this.organizer,
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
    this.materials,
    this.participants,
  });

}