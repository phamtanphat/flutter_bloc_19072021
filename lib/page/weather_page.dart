import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_19072021/model/weather.dart';
import 'package:flutter_bloc_19072021/page/weather_bloc.dart';
import 'package:flutter_bloc_19072021/page/weather_event.dart';
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
      child: WeatherPageContainer(),
    );
  }
}

class WeatherPageContainer extends StatefulWidget {

  @override
  _WeatherPageContainerState createState() => _WeatherPageContainerState();
}

class _WeatherPageContainerState extends State<WeatherPageContainer> {
  late WeatherBloc bloc;
  bool showSearchBox = false;

  @override
  void initState() {
    super.initState();
    bloc = context.read();
  }

  void changeStatusSearchBox(){
    setState(() {
      showSearchBox = !showSearchBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Page"),
        actions: [
          showSearchBox ?
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal:  10 , vertical: 5),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.start,
                          onSubmitted: (text){
                            bloc.addEvent(WeatherEvent(cityName: text));
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Example : Chicago",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: changeStatusSearchBox,
                        icon: Icon(Icons.close)
                    )
                  ],
                ),
              )
              :
              IconButton(
                onPressed: changeStatusSearchBox,
                icon: Icon(Icons.search),
              )
        ],
      ),
      body: StreamBuilder<Weather>(
        stream: bloc.weatherStream,
        builder: (context, snapshot){
          if (snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString() , style: TextStyle(fontSize: 30)),
            );
          }
          switch(snapshot.connectionState){
            case ConnectionState.active :
              Weather weather = snapshot.data as Weather;
              return Column(
                children: [
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                              weather.title ,
                              style: TextStyle(fontSize: 40 , fontWeight: FontWeight.bold , color : Colors.red)
                          )
                      )
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network("https://www.metaweather.com/static/img/weather/png/64/${weather.weatherAB}.png"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text("Temp : ${weather.temp.toString().substring(0 ,2)} °C" , style: TextStyle(color: Colors.black)),
                            Text("Min Temp : ${weather.minTemp.toString().substring(0 ,2)} °C" , style: TextStyle(color: Colors.black)),
                            Text("Max Temp : ${weather.maxTemp.toString().substring(0 ,2)} °C" , style: TextStyle(color: Colors.black)),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text("Created : ${weather.created} " , style: TextStyle(color: Colors.black)),
                ],
              );
              break;
            default :
              return SizedBox();
          }
        },
      ),
    );
  }
}



