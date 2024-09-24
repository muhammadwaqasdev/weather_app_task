class Weather {
  final double lon;
  final double lat;
  final String main;
  final String description;
  final String icon;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int clouds;
  final String cityName;
  final String country;
  final int sunrise;
  final int sunset;

  Weather({
    required this.lon,
    required this.lat,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.clouds,
    required this.cityName,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  // Factory method to convert JSON into Weather object
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      lon: json['coord']['lon'],
      lat: json['coord']['lat'],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      temp: json['main']['temp'] - 273.15,
      feelsLike: json['main']['feels_like'] - 273.15,
      tempMin: json['main']['temp_min'] - 273.15,
      tempMax: json['main']['temp_max'] - 273.15,
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      clouds: json['clouds']['all'],
      cityName: json['name'],
      country: json['sys']['country'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }
}
