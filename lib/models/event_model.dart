import 'package:assignment/models/base_model.dart';
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

enum EventStatus {
  scheduled,
  ongoing,
  completed,
  cancelled,
  postponed,
}

class EventModel implements BaseModel {
  final ProfileModel organizer;
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
  final EventStatus status;
  List<String>? materials;
  List<ProfileModel>? participants;

  EventModel({
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
    required this.status,
    this.materials,
    this.participants,
  });

  @override
  factory EventModel.fromMap(Map<String, dynamic> map) => EventModel(
        organizer: map['organizer'],
        title: map['title'],
        description: map['description'],
        venue: map['venue'],
        fees: map['fees'],
        contact: map['contact'],
        type: EventType.values[map['type']],
        datetime: List<DateTime>.from(map['datetime']),
        capacity: map['capacity'],
        imageLink: map['imageLink'],
        isAnonymous: map['isAnonymous'],
        status: EventStatus.values[map['status']],
        materials: List<String>.from(map['materials']),
        participants: List<ProfileModel>.from(
            map['participants'].map((item) => ProfileModel.fromMap(item))),
      );

  @override
  Map<String, dynamic> toMap() => {
        'organizer': organizer,
        'title': title,
        'description': description,
        'venue': venue,
        'fees': fees,
        'contact': contact,
        'type': type,
        'datetime': datetime,
        'capacity': capacity,
        'imageLink': imageLink,
        'isAnonymous': isAnonymous,
        'status': status,
        'materials': materials,
        'participants': participants,
      };
}
