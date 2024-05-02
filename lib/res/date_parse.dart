import 'package:intl/intl.dart';


class DateParse{
  static String getHourWithAm(String time){
    // String dateString = "2024-04-28 22:00";
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
    DateTime dateTime = format.parse(time);
    return '${dateTime.hour>12? dateTime.hour-12 : dateTime.hour==0? 12: dateTime.hour  } ${dateTime.hour>12? "PM" : "AM" } ';
  }

  static (List<T>, int) removePastHour<T>(List<T>list, String test ){
    // test actually to check is same date then we can short out

    DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
    final time = format.parse(test);
    if(time.day != DateTime.now().day){
      return (list, -1);
    }

    int currentHour = DateTime.now().hour;

    final List<T>result = [];
    for(int index=currentHour; index<list.length; index++){
        result.add(list[index]);
    }
    return (result, currentHour);
  }

  static bool isTakeFromCurrent({ String? current,  String? hour}){
     if(current==null || hour==null){
       return false;
     }
     DateFormat format = DateFormat("yyyy-MM-dd HH:mm");
     final currentTime = format.parse(current);
     final hourTime = format.parse(hour);
     if(currentTime.isBefore(hourTime)) return false;

     return true;
  }

  static String convertNowToHourMinute(){
    final time = DateTime.now();
    final extension = time.hour>12 ? 'PM' : 'AM';
    return time.hour>13 ? '${time.hour-12}:$extension': '${time.hour}:$extension';
  }

  static String convertTodayYesterday(String time){
    final now = DateTime.now();
    DateFormat format = DateFormat("yyyy-MM-dd");
    final timeDate = format.parse(time);
    if(timeDate.day == now.day){
      return 'Today';
    }
    if(timeDate.day==now.day-1 ){
      return 'Yesterday';
    }
    if(timeDate.day ==now.day+1 ){
      return 'Tomorrow';
    }
    return time;

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