
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

class EventModel {
  final String? id;
  final String organizerEmail;
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
        fees: map['fees'],
        contact: map['contact'],
        type: EventType.values[map['type']],
        datetime: List<DateTime>.from(map['datetime']),
        capacity: map['capacity'],
        imageLink: map['imageLink'],
        isAnonymous: map['isAnonymous'],
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
        'datetime': datetime,
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
    List<DateTime>? datetime,
    String? capacity,
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
