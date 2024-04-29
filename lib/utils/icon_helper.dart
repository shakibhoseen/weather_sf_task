import 'package:weather_sf_task/res/date_parse.dart';

class IconHelper {
  static const basePath = 'assets/svg/';

  static String getFullPath(String path) => '$basePath$path.svg';

  static String getSvgIcon({required int code, bool isNight = false}) {
    switch (code) {
      case 1000:
        return isNight ? getFullPath('clear-night') : getFullPath('clear-day');
      case 1003:
        return !isNight
            ? getFullPath('partly-cloudy-day')
            : getFullPath('partly-cloudy-night');

      case 1006:
        return isNight ? getFullPath('cloudy') : getFullPath('cloudy');

      case 1009:
        return !isNight
            ? getFullPath('overcast-day')
            : getFullPath('overcast-night');

      case 1030:
        return isNight ? getFullPath('mist') : getFullPath('mist');

      case 1063:
        return isNight
            ? getFullPath('partly-cloudy-night-rain')
            : getFullPath('partly-cloudy-day-rain');

      case 1066:
      case 1255:
      case 1258:
      case 1261:
      case 1264:
        return isNight
            ? getFullPath('partly-cloudy-night-snow')
            : getFullPath('partly-cloudy-day-snow');

      case 1069:
      case 1249:
      case 1252:
        return isNight
            ? getFullPath('partly-cloudy-night-sleet')
            : getFullPath('partly-cloudy-day-sleet');

      case 1072:
        return isNight
            ? getFullPath('partly-cloudy-night-drizzle')
            : getFullPath('partly-cloudy-day-drizzle');

      case 1087:
        return isNight
            ? getFullPath('thunderstorms-night')
            : getFullPath('thunderstorms-day');

      case 1114:
        return isNight ? getFullPath('snow') : getFullPath('snow');

      case 1117:
        return isNight ? getFullPath('snow') : getFullPath('snow');
      case 1135:
        return isNight ? getFullPath('fog') : getFullPath('fog');

      case 1147:
       return isNight ? getFullPath('haze') : getFullPath('haze');

      case 1150:
        return isNight
            ? getFullPath('partly-cloudy-night-drizzle')
            : getFullPath('partly-cloudy-day-drizzle');

      case 1153:
        return isNight ? getFullPath('drizzle') : getFullPath('drizzle');

      case 1168:
      case 1171:
        return isNight ? getFullPath('drizzle') : getFullPath('drizzle');

      case 1180:
      case 1240:
      case 1243:
        return isNight
            ? getFullPath('partly-cloudy-night-rain')
            : getFullPath('partly-cloudy-day-rain');

      case 1183:
      case 1186:
      case 1189:
      case 1192:
      case 1195:
      case 1198:
      case 1201:
      case 1246:
        return isNight ? getFullPath('rain') : getFullPath('rain');

      case 1204:
      case 1207:
        return isNight ? getFullPath('sleet') : getFullPath('sleet');

      case 1210:
      case 1222:
        return isNight
            ? getFullPath('partly-cloudy-night-snow')
            : getFullPath('partly-cloudy-day-snow');

      case 1213:
      case 1216:
      case 1219:
      case 1225:
        return isNight ? getFullPath('snow') : getFullPath('snow');

      case 1237:
        return isNight ? getFullPath('hail') : getFullPath('hail');

      case 1273:
        return isNight
            ? getFullPath('thunderstorms-night-rain')
            : getFullPath('thunderstorms-day-rain');

      case 1276:
      case 1282:
        return isNight
            ? getFullPath('thunderstorms-rain')
            : getFullPath('thunderstorms-rain');

      case 1279:
        return isNight
            ? getFullPath('thunderstorms-night-snow')
            : getFullPath('thunderstorms-day-snow');

      default:
        return isNight ? getFullPath('clear-night') : getFullPath('clear-day');
    }
  }
}
