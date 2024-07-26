abstract class BaseRequestModel {
  String? get id;

  factory BaseRequestModel.fromMap(String id, Map<String, dynamic> map) {
    throw UnimplementedError('fromMap() has not been implemented.');
  }

  Map<String, dynamic> toMap();

  BaseRequestModel copyWith({
    String? id,
    String? date,
    String? userEmail,
    String? status,
    String? type,
    String? description,
    List<String>? supportingDocs,
  });
}

class RequestModel implements BaseRequestModel {
  ///for request and feedback
  @override
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

  @override
  Map<String, dynamic> toMap() => {
        'userEmail': userEmail,
        'date': date,
        'status': status,
        'type': type,
        'description': description,
        'supportingDocs': supportingDocs,
      };

  @override
  RequestModel copyWith({
    String? id,
    String? date,
    String? userEmail,
    String? status,
    String? type,
    String? description,
    List<String>? supportingDocs,
  }) =>
      RequestModel(
        id: id ?? this.id,
        userEmail: userEmail ?? this.userEmail,
        date: date ?? this.date,
        status: status ?? this.status,
        type: type ?? this.type,
        description: description ?? this.description,
        supportingDocs: supportingDocs ?? this.supportingDocs,
      );
}

class ReportModel implements BaseRequestModel {
  ///for report user
  @override
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

  @override
  Map<String, dynamic> toMap() => {
        'userEmail': userEmail,
        'reportedUserEmail': reportedUserEmail,
        'date': date,
        'status': status,
        'type': type,
        'description': description,
        'supportingDocs': supportingDocs,
      };

  @override
  ReportModel copyWith({
    String? id,
    String? date,
    String? userEmail,
    String? reportedUserEmail,
    String? status,
    String? type,
    String? description,
    List<String>? supportingDocs,
  }) =>
      ReportModel(
        id: id ?? this.id,
        userEmail: userEmail ?? this.userEmail,
        reportedUserEmail: reportedUserEmail ?? this.reportedUserEmail,
        date: date ?? this.date,
        status: status ?? this.status,
        type: type ?? this.type,
        description: description ?? this.description,
        supportingDocs: supportingDocs ?? this.supportingDocs,
      );
}
