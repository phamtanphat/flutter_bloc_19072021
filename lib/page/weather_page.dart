import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_19072021/page/weather_bloc.dart';
import 'package:flutter_bloc_19072021/repository/weather_repository.dart';
import 'package:flutter_bloc_19072021/request/weather_request.dart';
import 'package:provider/provider.dart';
class WeatherPage extends StatefulWidget {

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          Provider(create: (_) => WeatherRequest()),
          ProxyProvider<WeatherRequest , WeatherRepository>(
            create: (context) => WeatherRepository(),
            update: (context, weatherRequest, weatherRepository){
              weatherRepository!.updateWeatherRequest(weatherRequest);
              return weatherRepository;
            },
          ),
          ChangeNotifierProxyProvider<WeatherRepository , WeatherBloc>(
            create: (context) => WeatherBloc(),
            update: (context, weatherRepo, weatherBloc){
              weatherBloc!.updateWeatherRepository(weatherRepo);
              return weatherBloc;
            },
          )
      ],
    );
  }
}


