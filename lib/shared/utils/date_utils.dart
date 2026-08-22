import 'package:intl/intl.dart';

class DateUtil {
  DateUtil._();
  static String calculateAge(String birthDateString) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime birthDate = dateFormat.parse(birthDateString);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }
}
