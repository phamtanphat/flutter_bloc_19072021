enum WeatherState{
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather{
  final String title;
  final int id;
  final WeatherState weatherState;
  final String weatherAB;
  final String created;
  final double temp;
  final double minTemp;
  final double maxTemp;

  Weather({
    required this.title,
    required this.id,
    required this.weatherState,
    required this.weatherAB,
    required this.created,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
  });

  static WeatherState tranFormAbToState(String ab){
    Map<String , WeatherState> mapWeather = {
      'sn': WeatherState.snow,
      'sl': WeatherState.sleet,
      'h': WeatherState.hail,
      't': WeatherState.thunderstorm,
      'hr': WeatherState.heavyRain,
      'lr': WeatherState.lightRain,
      's': WeatherState.showers,
      'hc': WeatherState.heavyCloud,
      'lc': WeatherState.lightCloud,
      'c': WeatherState.clear
    };
    return mapWeather[ab] ?? WeatherState.unknown;
  }

  static Weather fromJson(dynamic json){
    var array = json['consolidated_weather'];
    var objectWeather = array[0];
    return Weather(
      id: json['woeid'],
      title: json['title'],
      weatherState: tranFormAbToState(objectWeather['weather_state_abbr']),
      weatherAB: objectWeather['weather_state_abbr'],
      created: json['time'],
      temp: objectWeather['the_temp'],
      minTemp: objectWeather['min_temp'],
      maxTemp: objectWeather['max_temp'],
    );
  }

  @override
  String toString() {
    return 'Weather{title: $title, id: $id, weatherState: $weatherState, weatherAB: $weatherAB, created: $created, temp: $temp, minTemp: $minTemp, maxTemp: $maxTemp}';
  }
}

