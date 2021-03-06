import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_19072021/model/weather.dart';
import 'package:flutter_bloc_19072021/request/weather_request.dart';

class WeatherRepository{

  late WeatherRequest weatherRequest;

  WeatherRepository();

  void updateWeatherRequest(WeatherRequest weatherRequest){
    this.weatherRequest = weatherRequest;
  }

  Future<int> fetchIdFromCityName(String city) async{
    Completer<int> completer = new Completer();
    try{
      Response response = await weatherRequest.getIdFromCityName(city);
      if (response.statusCode == 200){
        var arrayData = response.data as List;
        if (arrayData.length <= 0){
          completer.completeError("City not found");
        }else{
          var woeid = arrayData[0]["woeid"];
          completer.complete(woeid);
        }
      }
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<Weather> fetchWeatherFromId(int id) async{
    Completer<Weather> completer = Completer();
    try{
      Response response = await weatherRequest.getWeatherFromId(id);
      Weather weather = Weather.fromJson(response.data);
      completer.complete(weather);
    }catch(e){
      completer.completeError(e);
    }
    return completer.future;
  }

}