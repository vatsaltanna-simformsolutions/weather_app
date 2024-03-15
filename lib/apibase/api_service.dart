import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/model/current_weather.dart';
import 'package:weather_app/model/days_forecast.dart';
import 'package:weather_app/model/locations.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/model/response/weather.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  /// Login
  @GET('/weather')
  Future<CurrentWeather> getCurrentWeather({
    @Query('lat') double? lat,
    @Query('lon') double? long,
  });

  /// Login
  @GET('/forecast/daily')
  Future<DaysForecast> getDaysForecast({
    @Query('lat') double? lat,
    @Query('lon') double? long,
    @Query('cnt') int? days,
  });

  /// Login
  @GET('/forecast')
  Future<DaysForecast> getHourlyForecast({
    @Query('lat') double? lat,
    @Query('lon') double? long,
  });

  /// Search City
  @GET('/search')
  Future<Locations> getCityNames({
    @Query('name') String? name,
    @Query('count') int? count,
  });
}
