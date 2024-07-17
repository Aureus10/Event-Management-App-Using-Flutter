import 'package:google_maps_flutter/google_maps_flutter.dart';

String formatLocationToString(LatLng location) {
  return '${location.latitude.toStringAsFixed(6)}, ${location.longitude.toStringAsFixed(6)}';
}

LatLng formatStringToLocation(String location) {
  List<String> parts = location.split(','); // Split the input string by comma
  
  if (parts.length != 2) {
    throw FormatException('Invalid location format'); // Handle invalid format
  }
  
  try {
    double lat = double.parse(parts[0].trim()); // Parse latitude
    double lng = double.parse(parts[1].trim()); // Parse longitude
    return LatLng(lat, lng); // Return LatLng object
  } catch (e) {
    throw FormatException('Error parsing location: $e'); // Handle parsing error
  }
}

String formatDateTimeToString(DateTime dateTime) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  
  String year = dateTime.year.toString();
  String month = twoDigits(dateTime.month);
  String day = twoDigits(dateTime.day);
  String hour = twoDigits(dateTime.hour);
  String minute = twoDigits(dateTime.minute);
  // String second = twoDigits(dateTime.second);
  
  return '$year-$month-$day $hour:$minute';
}

DateTime formatDateTime (DateTime dateTime) {
  return DateTime(
    dateTime.year,
    dateTime.month,
    dateTime.day,
    dateTime.hour,
    dateTime.minute,
    dateTime.second,
  );
}