import 'package:intl/intl.dart';

String separateDate(String dateTimeString) {
  // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Extract date and time components
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}

String separateTime(String dateTimeString) {
  // Parse the input string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Extract date and time components
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
}

String convertTo24HourFormat(String pmTime) {
  // Parse the input time string with AM/PM format
  DateTime dateTime = DateFormat("hh:mm:ss a").parse(pmTime);

  // Format the DateTime object in 24-hour format
  String twentyFourHourFormat = DateFormat("HH:mm:ss").format(dateTime);

  return twentyFourHourFormat;
}

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedDate;
}

String formatTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('HH:mm').format(dateTime);
  return formattedDate;
}
