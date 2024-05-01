import 'package:intl/intl.dart';

class DateParse{
  static String getHourWithAm(String time){
    // String dateString = "2024-04-28 22:00";
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dateTime = format.parse(time);
    return '${dateTime.hour>12? dateTime.hour-12 : dateTime.hour==0? 12: dateTime.hour  } ${dateTime.hour>12? "PM" : "AM" } ';
  }


}

class DayHelper{
  final String sunrise, sunset;

  DayHelper({required this.sunrise, required this.sunset});

  bool isDayOrNight({required String time}) {
    if(time.isEmpty ) false;
    // Extract hours from sunrise and sunset strings
    int sunriseHour = int.parse(sunrise.split(':')[0]);
    int sunsetHour = int.parse(sunset.split(':')[0]);

    // Get current hour
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dateTime = format.parse(time);
    int currentHour = dateTime.hour;

    // Check if current hour is between sunrise and sunset
    if (currentHour >= sunriseHour && currentHour < sunsetHour+12) {
      return false; // It's day
    } else {
      return true; // It's night
    }
  }
}