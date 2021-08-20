import 'package:flutter_bloc_19072021/dio/dio_client.dart';

class WeatherRequest{
  
  Future getIdFromCityName(String cityName){
    return DioClient().dio.get("api/location/search/?query=$cityName");
  }
  
  Future getWeatherFromId(int id){
    return DioClient().dio.get("api/location/$id");
  }

}