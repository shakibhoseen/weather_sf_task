import 'dart:convert';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:weather_sf_task/model/weather_parrent_model.dart';

const key = 'jsonKey', boxName = 'myBox';

class MyJsonData {
  final WeatherParentData weatherParentData;

  MyJsonData(this.weatherParentData);
}

class MyHiveRepository {
  void saveData(WeatherParentData weatherParentData) async {

    final box = await Hive.openBox(boxName);

    // Store JSON data
    await Hive.box(boxName).put(key, MyJsonData(weatherParentData).toJson());

    box.close();
  }

  Future<WeatherParentData?> getStoreData() async{
    final box = await Hive.openBox(boxName);
    // Retrieve JSON data
    final storedJson = await box.get(key) as String?;
    box.close();
    if(storedJson ==null){
      return null;
    }
    return WeatherParentData.fromJson(jsonDecode(storedJson));
  }
}

extension JsonSerializable on MyJsonData {
  String toJson() {
    return jsonEncode(weatherParentData.toJson());
  }
}
