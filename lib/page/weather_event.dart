import 'package:flutter_bloc_19072021/base/base_bloc.dart';
import 'package:flutter_bloc_19072021/base/base_event.dart';

class WeatherEvent extends BaseEvent{
  final String cityName;

  WeatherEvent({required this.cityName});

 @override
  // TODO: implement props
  List<Object?> get props => [cityName];

}