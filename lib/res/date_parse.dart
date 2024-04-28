import 'package:intl/intl.dart';

class DateParse{
  static String getHourWithAm(String time){
    // String dateString = "2024-04-28 22:00";
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dateTime = format.parse(time);
    return '${dateTime.hour>12? dateTime.hour-12 : dateTime.hour==0? 12: dateTime.hour  } ${dateTime.hour>12? "PM" : "AM" } ';
  }
}