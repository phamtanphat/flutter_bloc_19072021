import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class WeatherPage extends StatefulWidget {

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  @override
  void didUpdateWidget(covariant WeatherPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchApiDemo1();
  }

  void fetchApiDemo1() async{
    // Dio().get("https://khoapham.vn/KhoaPhamTraining/json/tien/demo1.json")
    //     .then((value) => print(value))
    //     .catchError((error) => print(error));

    Response response = await Dio().get("https://khoapham.vn/KhoaPhamTraining/json/tien/demo1.json");
    if (response.statusCode == 200){
      print(response.data['monhoc'].toString());
    }

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
