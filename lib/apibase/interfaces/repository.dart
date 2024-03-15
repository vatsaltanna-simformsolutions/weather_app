import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/model/locations.dart';

abstract class RepositoryBase {
  const RepositoryBase();

  Future<CurrentWeather> getCurrentWeather(double lat, double long);

  Future<CurrentWeather> getHourlyWeather(double lat, double long);

  Future<DaysForecast> getDaysForecast(double lat, double long, int days);

  Future<Locations> getCityNames({required String name});
}
