import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class Utils{
  static showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static showFlashBarMessage(
      String message, FlashType type, BuildContext context) {
    ///may be you think why i am using WidgetBinding, cause ensure its not show untill
    /// build process is finish untill flutter exception will happen, like inside async operation
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showFlushbar(
          context: context,
          flushbar: Flushbar(
            title: type == FlashType.success ? "Success" : "Error",
            icon: Icon(
              type == FlashType.success ? Icons.thumb_up : Icons.error,
              color: Colors.white,
            ),
            message: message,
            backgroundColor: type == FlashType.success ? Colors.green : Colors.red,
            titleColor: Colors.white,
            messageColor: Colors.white,
            duration: const Duration(seconds: 4),
            flushbarPosition: FlushbarPosition.TOP,
          )..show(context));
    });

  }
}
enum FlashType { error, success }