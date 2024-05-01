import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetConnectivity{
  Future<bool?> checkInternet(BuildContext context) async{
    try{


    return await Connectivity().checkConnectivity().then(
            (connectivityResult){
      if (connectivityResult.contains(ConnectivityResult.none)) {
        log('no activity found');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'You\'re not connected to a network so we collect data from Hive')
            ));
          return false;
      } else {
        log('Internet activity found');
         ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('You\'re connected so we try to fetch data from net. please wait')
            ));
        return true;
      }
    });

    }on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return null;
    }

  }
}