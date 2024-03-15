import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/model/day_temperature.dart';
import 'package:weather_app/model/feels_like.dart';
import 'package:weather_app/model/weather.dart';

part 'day_weather.g.dart';

@JsonSerializable()
class DayWeather {
  @JsonKey(name: "dt")
  final int? dt;
  @JsonKey(name: "sunrise")
  final int? sunrise;
  @JsonKey(name: "sunset")
  final int? sunset;
  @JsonKey(name: "temp")
  final DayTemperature? temp;
  @JsonKey(name: "feels_like")
  final FeelsLike? feelsLike;
  @JsonKey(name: "pressure")
  final int? pressure;
  @JsonKey(name: "humidity")
  final int? humidity;
  @JsonKey(name: "weather")
  final List<Weather>? weather;
  @JsonKey(name: "speed")
  final double? speed;
  @JsonKey(name: "deg")
  final int? deg;
  @JsonKey(name: "gust")
  final double? gust;
  @JsonKey(name: "clouds")
  final int? clouds;
  @JsonKey(name: "pop")
  final double? pop;
  @JsonKey(name: "rain")
  final double? rain;

  DayWeather({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.weather,
    this.speed,
    this.deg,
    this.gust,
    this.clouds,
    this.pop,
    this.rain,
  });

  DayWeather copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    DayTemperature? temp,
    FeelsLike? feelsLike,
    int? pressure,
    int? humidity,
    List<Weather>? weather,
    double? speed,
    int? deg,
    double? gust,
    int? clouds,
    double? pop,
    double? rain,
  }) =>
      DayWeather(
        dt: dt ?? this.dt,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        weather: weather ?? this.weather,
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
        gust: gust ?? this.gust,
        clouds: clouds ?? this.clouds,
        pop: pop ?? this.pop,
        rain: rain ?? this.rain,
      );

  factory DayWeather.fromJson(Map<String, dynamic> json) =>
      _$DayWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$DayWeatherToJson(this);
}
