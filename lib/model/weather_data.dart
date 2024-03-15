import 'package:json_annotation/json_annotation.dart';

part 'weather_data.g.dart';

@JsonSerializable()
class WeatherData {
  @JsonKey(name: "temp")
  final double? temp;
  @JsonKey(name: "feels_like")
  final double? feelsLike;
  @JsonKey(name: "temp_min")
  final double? tempMin;
  @JsonKey(name: "temp_max")
  final double? tempMax;
  @JsonKey(name: "pressure")
  final int? pressure;
  @JsonKey(name: "humidity")
  final int? humidity;

  WeatherData({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  WeatherData copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
  }) =>
      WeatherData(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
      );

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataToJson(this);
}
