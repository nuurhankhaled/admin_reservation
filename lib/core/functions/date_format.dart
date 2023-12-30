import 'package:easy_localization/easy_localization.dart';

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