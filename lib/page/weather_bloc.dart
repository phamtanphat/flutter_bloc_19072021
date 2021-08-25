import 'dart:async';

import 'package:flutter_bloc_19072021/base/base_bloc.dart';
import 'package:flutter_bloc_19072021/base/base_event.dart';
import 'package:flutter_bloc_19072021/model/weather.dart';
import 'package:flutter_bloc_19072021/page/weather_event.dart';
import 'package:flutter_bloc_19072021/repository/weather_repository.dart';

class WeatherBloc extends BaseBloc{
  late WeatherRepository weatherRepository;
  StreamController<Weather> _weatherController = StreamController();

  Stream<Weather> get weatherStream => _weatherController.stream;

  WeatherBloc();

  void updateWeatherRepository(WeatherRepository weatherRepository){
    this.weatherRepository = weatherRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType){
      case WeatherEvent :
        fetchWeather(event as WeatherEvent);
        break;
    }
  }

  void fetchWeather(WeatherEvent event) async{
    try{
      var id = await weatherRepository.fetchIdFromCityName(event.cityName);
      var weather = await weatherRepository.fetchWeatherFromId(id);
      _weatherController.sink.add(weather);
    }catch(e){
      _weatherController.sink.addError(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _weatherController.close();
  }




}