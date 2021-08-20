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

}

