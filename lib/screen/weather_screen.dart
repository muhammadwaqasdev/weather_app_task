import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/weather_data_model.dart';
import '../provider/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final city = _controller.text;
                if (city.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false)
                      .fetchWeather(city);
                }
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 16),
            Consumer<WeatherProvider>(
              builder: (context, provider, _) {
                if (provider.loading) {
                  return const CircularProgressIndicator();
                } else if (provider.error != null) {
                  return Text(provider.error!);
                } else if (provider.weather != null) {
                  Weather weather = provider.weather!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City: ${weather.cityName}, ${weather.country}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('Temperature: ${weather.temp.ceil()}°C'),
                      Text('Feels Like: ${weather.feelsLike.ceil()}°C'),
                      Text('Min Temperature: ${weather.tempMin.ceil()}°C'),
                      Text('Max Temperature: ${weather.tempMax.ceil()}°C'),
                      Text('Description: ${weather.description}'),
                      Text('Humidity: ${weather.humidity}%'),
                      Text('Pressure: ${weather.pressure} hPa'),
                      Text('Wind Speed: ${weather.windSpeed} m/s'),
                      Text('Cloudiness: ${weather.clouds}%'),
                      Text(
                          'Sunrise: ${DateTime.fromMillisecondsSinceEpoch(weather.sunrise * 1000)}'),
                      Text(
                          'Sunset: ${DateTime.fromMillisecondsSinceEpoch(weather.sunset * 1000)}'),
                    ],
                  );
                } else {
                  return const Text('Enter a city to get weather information.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
