import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class WeatherPage extends StatefulWidget {

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {


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


