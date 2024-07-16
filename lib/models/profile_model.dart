enum UserType { user, organizer, administrator }

enum Gender { male, female }

enum AccountStatus { active, inactive, banned }

class ProfileModel {
  final String email;
  final UserType type;
  final String dateOfBirth;
  final String username;
  final Gender gender;
  final String contact;
  final List<String>? eventHistory;
  final int creditScore;
  final String imageLink;
  final AccountStatus status;

  const ProfileModel({
    required this.email,
    required this.type,
    required this.dateOfBirth,
    required this.username,
    required this.gender,
    required this.contact,
    required this.creditScore,
    required this.imageLink,
    required this.status,
    this.eventHistory,
  });

  @override
  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
        email: map['email'],
        type: UserType.values[map['type']],
        dateOfBirth: map['dateOfBirth'],
        username: map['username'],
        gender: Gender.values[map['gender']],
        contact: map['contact'],
        eventHistory: List<String>.from(map['eventHistory']),
        creditScore: int.parse(map['creditScore']),
        imageLink: map['imageLink'],
        status: AccountStatus.values[map['status']],
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'username': username,
        'type': type.toString().split('.').last,
        'dateOfBirth': dateOfBirth,
        'gender': gender.toString().split('.').last,
        'contact': contact,
        'eventHistory': eventHistory,
        'creditScore': creditScore,
        'imageLink': imageLink,
        'status': status.toString().split('.').last,
      };

  ProfileModel copyWith({
    String? email,
    UserType? type,
    String? dateOfBirth,
    String? username,
    Gender? gender,
    String? contact,
    List<String>? eventHistory,
    int? creditScore,
    String? imageLink,
    AccountStatus? status,
  }) {
    return ProfileModel(
        type: type ?? this.type,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        username: username ?? this.username,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        contact: contact ?? this.contact,
        eventHistory: eventHistory ?? this.eventHistory ?? [],
        creditScore: creditScore ?? this.creditScore,
        imageLink: imageLink ?? this.imageLink,
        status: status ?? this.status);
  }
}
