// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayWeather _$DayWeatherFromJson(Map<String, dynamic> json) => DayWeather(
      dt: json['dt'] as int?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
      temp: json['temp'] == null
          ? null
          : DayTemperature.fromJson(json['temp'] as Map<String, dynamic>),
      feelsLike: json['feels_like'] == null
          ? null
          : FeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
      pressure: json['pressure'] as int?,
      humidity: json['humidity'] as int?,
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      speed: (json['speed'] as num?)?.toDouble(),
      deg: json['deg'] as int?,
      gust: (json['gust'] as num?)?.toDouble(),
      clouds: json['clouds'] as int?,
      pop: (json['pop'] as num?)?.toDouble(),
      rain: (json['rain'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DayWeatherToJson(DayWeather instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'weather': instance.weather,
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
      'clouds': instance.clouds,
      'pop': instance.pop,
      'rain': instance.rain,
    };
