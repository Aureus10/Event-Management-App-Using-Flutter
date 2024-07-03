import 'package:assignment/models/event_model.dart';

enum UserType {
  user,
  organizer,
  administrator
}

enum Gender {
  male,
  female
}

class Profile {

  final int id;
  final UserType type;
  final int age;
  final Gender gender;
  final String email;
  final String contact;
  final List<Event> eventHistory;
  final int creditScore;
  final String imageLink;

  const Profile({
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

}