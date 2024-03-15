import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/model/clouds.dart';
import 'package:weather_app/model/sys.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/model/wind.dart';

import 'coord.dart';

part 'current_weather.g.dart';

@JsonSerializable()
class CurrentWeather {
  @JsonKey(name: "coord")
  final Coord? coord;
  @JsonKey(name: "weather")
  final List<Weather>? weather;
  @JsonKey(name: "base")
  final String? base;
  @JsonKey(name: "main")
  final WeatherData? weatherData;
  @JsonKey(name: "visibility")
  final int? visibility;
  @JsonKey(name: "wind")
  final Wind? wind;
  @JsonKey(name: "clouds")
  final Clouds? clouds;
  @JsonKey(name: "dt")
  final int? dt;
  @JsonKey(name: "sys")
  final Sys? sys;
  @JsonKey(name: "timezone")
  final int? timezone;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "cod")
  final int? cod;

  CurrentWeather({
    this.coord,
    this.weather,
    this.base,
    this.weatherData,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  CurrentWeather copyWith({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    WeatherData? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) =>
      CurrentWeather(
        coord: coord ?? this.coord,
        weather: weather ?? this.weather,
        base: base ?? this.base,
        weatherData: main ?? weatherData,
        visibility: visibility ?? this.visibility,
        wind: wind ?? this.wind,
        clouds: clouds ?? this.clouds,
        dt: dt ?? this.dt,
        sys: sys ?? this.sys,
        timezone: timezone ?? this.timezone,
        id: id ?? this.id,
        name: name ?? this.name,
        cod: cod ?? this.cod,
      );

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);
}
