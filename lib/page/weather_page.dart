import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_19072021/repository/weather_repository.dart';
import 'package:flutter_bloc_19072021/request/weather_request.dart';
class WeatherPage extends StatefulWidget {

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late WeatherRepository repository;

  @override
  void initState() {
    super.initState();
    repository = WeatherRepository(weatherRequest: WeatherRequest());
  }

  @override
  void didUpdateWidget(covariant WeatherPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    repository.fetchIdFromCityName("abc");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Container(
        child: Text("Demo"),
      ),
    );
  }
}


