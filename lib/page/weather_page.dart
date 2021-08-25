import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    bloc.addEvent(WeatherEvent(cityName: "chicago"));
  }

  @override
  void didUpdateWidget(covariant WeatherPageContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    bloc.addEvent(WeatherEvent(cityName: "abcxyz"));
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
      body: Container(
        child: Center(
          child: Text("Demo"),
        ),
      ),
    );
  }
}



