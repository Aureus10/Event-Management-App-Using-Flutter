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

  final String id;
  final int age;
  final Gender gender;
  final String email;
  final String contact;
  final List<Event> eventHistory;
  final int creditScore;
  final String imageLink;
  final String passwordHash;
  final String salt;

  const Profile({
    required this.id,
    required this.age,
    required this.gender,
    required this.email,
    required this.contact,
    required this.eventHistory,
    required this.creditScore,
    required this.imageLink,
    required this.passwordHash,
    required this.salt,
  });

}