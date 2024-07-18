class ReportModel {
  final String? id;
  final String userEmail;
  final String reportedUserEmail;
  final String date;
  final String status;
  final String type;
  final String description;
  final List<String> supportingDocs;

  ReportModel({
    this.id,
    required this.userEmail,
    required this.reportedUserEmail,
    required this.date,
    required this.status,
    required this.type,
    required this.description,
    required this.supportingDocs,
  });

  factory ReportModel.fromMap(String id, Map<String, dynamic> map) =>
      ReportModel(
        id: id,
        userEmail: map['userEmail'],
        reportedUserEmail: map['reportedUserEmail'],
        date: map['date'],
        status: map['status'],
        type: map['type'],
        description: map['description'],
        supportingDocs: List<String>.from(map['supportingDocs']),
      );

  Map<String, dynamic> toMap() => {
        'userEmail': userEmail,
        'reportedUserEmail': reportedUserEmail,
        'date': date,
        'status': status,
        'type': type,
        'description': description,
        'supportingDocs': supportingDocs,
      };

  ReportModel copyWith({
    String? date,
    String? userEmail,
    String? reportedUserEmail,
    String? status,
    String? type,
    String? description,
    List<String>? supportingDocs,
  }) =>
      ReportModel(
        userEmail: userEmail ?? this.userEmail,
        reportedUserEmail: reportedUserEmail ?? this.reportedUserEmail,
        date: date ?? this.date,
        status: status ?? this.status,
        type: type ?? this.type,
        description: description ?? this.description,
        supportingDocs: supportingDocs ?? this.supportingDocs,
      );
}
