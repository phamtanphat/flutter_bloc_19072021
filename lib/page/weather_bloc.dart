import 'package:flutter_bloc_19072021/base/base_bloc.dart';
import 'package:flutter_bloc_19072021/base/base_event.dart';
import 'package:flutter_bloc_19072021/page/weather_event.dart';
import 'package:flutter_bloc_19072021/repository/weather_repository.dart';

class WeatherBloc extends BaseBloc{
  late WeatherRepository weatherRepository;

  WeatherBloc();

  void updateWeatherRepository(WeatherRepository weatherRepository){
    this.weatherRepository = weatherRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch(event.runtimeType){
      case WeatherEvent :
        print("ok");
        break;
    }
  }

}