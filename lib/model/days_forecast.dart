import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/model/city.dart';
import 'package:weather_app/model/day_weather.dart';

part 'days_forecast.g.dart';

@JsonSerializable()
class DaysForecast {
  @JsonKey(name: "city")
  final City? city;
  @JsonKey(name: "cod")
  final String? cod;
  @JsonKey(name: "message")
  final double? message;
  @JsonKey(name: "cnt")
  final int? cnt;
  @JsonKey(name: "list")
  final List<DayWeather>? list;

  DaysForecast({
    this.city,
    this.cod,
    this.message,
    this.cnt,
    this.list,
  });

  DaysForecast copyWith({
    City? city,
    String? cod,
    double? message,
    int? cnt,
    List<DayWeather>? list,
  }) =>
      DaysForecast(
        city: city ?? this.city,
        cod: cod ?? this.cod,
        message: message ?? this.message,
        cnt: cnt ?? this.cnt,
        list: list ?? this.list,
      );

  factory DaysForecast.fromJson(Map<String, dynamic> json) =>
      _$DaysForecastFromJson(json);

  Map<String, dynamic> toJson() => _$DaysForecastToJson(this);
}
