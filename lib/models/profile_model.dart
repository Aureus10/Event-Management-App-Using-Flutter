import 'package:assignment/models/event_model.dart';

enum UserType { user, organizer, administrator }

enum Gender { male, female }

class ProfileModel {
  final int id;
  final UserType type;
  final int age;
  final Gender gender;
  final String email;
  final String contact;
  final List<EventModel> eventHistory;
  final int creditScore;
  final String imageLink;

  const ProfileModel({
    required this.id,
    required this.type,
    required this.age,
    required this.gender,
    required this.email,
    required this.contact,
    required this.eventHistory,
    required this.creditScore,
    required this.imageLink,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
        id: map['id'],
        type: UserType.values[map['type']],
        age: map['age'],
        gender: Gender.values[map['gender']],
        email: map['email'],
        contact: map['contact'],
        eventHistory: List<EventModel>.from(
            map['eventHistory'].map((item) => EventModel.fromMap(item))),
        creditScore: map['creditScore'],
        imageLink: map['imageLink'],
      );

  Map<String, dynamic> toMap() => {
      'id': id,
      'type': type,
      'age': age,
      'gender': gender,
      'email': email,
      'contact': contact,
      'eventHistory': eventHistory.map((event) => event.toMap()).toList(),
      'creditScore': creditScore,
      'imageLink': imageLink,
    };
}
