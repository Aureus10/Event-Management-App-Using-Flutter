abstract class BaseModel {

  factory BaseModel.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError('fromMap() has not been implemented.');
  }

  Map<String, dynamic> toMap();
}