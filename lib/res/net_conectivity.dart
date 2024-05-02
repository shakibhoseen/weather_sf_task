import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

class NetConnectivity{
  static Future<bool?> checkInternet() async{
    try{


    return await Connectivity().checkConnectivity().then(
            (connectivityResult){
      if (connectivityResult.contains(ConnectivityResult.none)) {
        log('no activity found');

          return false;
      } else {
        log('Internet activity found');
          return true;
      }
    });

    }on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return null;
    }

  }
}