enum UserType { user, organizer, administrator }

enum Gender { male, female }

class ProfileModel {
  final int id;
  final UserType type;
  final int age;
  final Gender gender;
  final String email;
  final String contact;
  final List<String>? eventHistory;
  final int creditScore;
  final String imageLink;

  const ProfileModel({
    required this.id,
    required this.type,
    required this.age,
    required this.gender,
    required this.email,
    required this.contact,
    required this.creditScore,
    required this.imageLink,
    this.eventHistory,
  });

  @override
  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
        id: map['id'],
        type: UserType.values[map['type']],
        age: map['age'],
        gender: Gender.values[map['gender']],
        email: map['email'],
        contact: map['contact'],
        eventHistory: List<String>.from(map['eventHistory']),
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
        'eventHistory': eventHistory,
        'creditScore': creditScore,
        'imageLink': imageLink,
      };

  ProfileModel copyWith({
    UserType? type,
    int? age,
    Gender? gender,
    String? email,
    String? contact,
    List<String>? eventHistory,
    int? creditScore,
    String? imageLink,
  }) {
    return ProfileModel(
        id: id,
        type: type ?? this.type,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        contact: contact ?? this.contact,
        eventHistory: eventHistory ?? this.eventHistory ?? [],
        creditScore: creditScore ?? this.creditScore,
        imageLink: imageLink ?? this.imageLink);
  }
}
