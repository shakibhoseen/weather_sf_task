import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


Widget getWeatherIcon(int code) {
  switch (code) {
    case >= 200 && < 300 :
      return Image.asset(
          'assets/1.png'
      );
    case >= 300 && < 400 :
      return Image.asset(
          'assets/2.png'
      );
    case >= 500 && < 600 :
      return Image.asset(
          'assets/3.png'
      );
    case >= 600 && < 700 :
      return Image.asset(
          'assets/4.png'
      );
    case >= 700 && < 800 :
      return Image.asset(
          'assets/5.png'
      );
    case == 800 :
      return Image.asset(
          'assets/6.png'
      );
    case > 800 && <= 804 :
      return Image.asset(
          'assets/7.png'
      );
    default:
      return Image.asset(
          'assets/7.png'
      );
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 21) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}