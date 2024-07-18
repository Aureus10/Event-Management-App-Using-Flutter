class RequestModel {
  final String? id;
  final String userEmail;
  final String date;
  final String status;
  final String type;
  final String description;
  final List<String> supportingDocs;

  RequestModel({
    this.id,
    required this.userEmail,
    required this.date,
    required this.status,
    required this.type,
    required this.description,
    required this.supportingDocs,
  });

  factory RequestModel.fromMap(String id, Map<String, dynamic> map) =>
      RequestModel(
          id: id,
          userEmail: map['userEmail'],
          date: map['date'],
          status: map['status'],
          type: map['type'],
          description: map['description'],
          supportingDocs: List<String>.from(map['supportingDocs']),
          );

  Map<String, dynamic> toMap() => {
        'userEmail': userEmail,
        'date': date,
        'status': status,
        'type': type,
        'description': description,
        'supportingDocs': supportingDocs,
      };

  RequestModel copyWith({
    String? date,
    String? userEmail,
    String? status,
    String? type,
    String? description,
    List<String>? supportingDocs,
  }) =>
      RequestModel(
        userEmail: userEmail ?? this.userEmail,
        date: date ?? this.date,
        status: status ?? this.status,
        type: type ?? this.type,
        description: description ?? this.description,
        supportingDocs: supportingDocs ?? this.supportingDocs,
      );
}
