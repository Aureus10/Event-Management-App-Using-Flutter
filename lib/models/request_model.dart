abstract class BaseRequestModel {
  String? get id;
  String get date;
  String get status;
  String get type;
  String get description;

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
    Map<String, String>? supportingDocs,
  });
}

class RequestModel implements BaseRequestModel {
  ///for request and feedback
  @override
  final String? id;
  final String userEmail;
  @override
  final String date;
  @override
  final String status;
  @override
  final String type;
  @override
  final String description;
  final Map<String, String> supportingDocs;

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
        supportingDocs: Map<String, String>.from(map['supportingDocs']),
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
    Map<String, String>? supportingDocs,
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
  @override
  final String date;
  @override
  final String status;
  @override
  final String type;
  @override
  final String description;
  final Map<String, String> supportingDocs;

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
        supportingDocs: Map<String, String>.from(map['supportingDocs']),
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
    Map<String, String>? supportingDocs,
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
