// To parse this JSON data, do
//
//     final daysForecast = daysForecastFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'coord.dart';


part 'days_forecast.g.dart';

DaysForecast daysForecastFromJson(String str) => DaysForecast.fromJson(json.decode(str));

String daysForecastToJson(DaysForecast data) => json.encode(data.toJson());

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
  final List<ListElement>? list;

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
    List<ListElement>? list,
  }) =>
      DaysForecast(
        city: city ?? this.city,
        cod: cod ?? this.cod,
        message: message ?? this.message,
        cnt: cnt ?? this.cnt,
        list: list ?? this.list,
      );

  factory DaysForecast.fromJson(Map<String, dynamic> json) => _$DaysForecastFromJson(json);

  Map<String, dynamic> toJson() => _$DaysForecastToJson(this);
}

@JsonSerializable()
class City {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "coord")
  final Coord? coord;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "population")
  final int? population;
  @JsonKey(name: "timezone")
  final int? timezone;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
  });

  City copyWith({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        coord: coord ?? this.coord,
        country: country ?? this.country,
        population: population ?? this.population,
        timezone: timezone ?? this.timezone,
      );

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable()
class ListElement {
  @JsonKey(name: "dt")
  final int? dt;
  @JsonKey(name: "sunrise")
  final int? sunrise;
  @JsonKey(name: "sunset")
  final int? sunset;
  @JsonKey(name: "temp")
  final Temp? temp;
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

  ListElement({
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

  ListElement copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    Temp? temp,
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
      ListElement(
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

  factory ListElement.fromJson(Map<String, dynamic> json) => _$ListElementFromJson(json);

  Map<String, dynamic> toJson() => _$ListElementToJson(this);
}

@JsonSerializable()
class FeelsLike {
  @JsonKey(name: "day")
  final double? day;
  @JsonKey(name: "night")
  final double? night;
  @JsonKey(name: "eve")
  final double? eve;
  @JsonKey(name: "morn")
  final double? morn;

  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  FeelsLike copyWith({
    double? day,
    double? night,
    double? eve,
    double? morn,
  }) =>
      FeelsLike(
        day: day ?? this.day,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory FeelsLike.fromJson(Map<String, dynamic> json) => _$FeelsLikeFromJson(json);

  Map<String, dynamic> toJson() => _$FeelsLikeToJson(this);
}

@JsonSerializable()
class Temp {
  @JsonKey(name: "day")
  final double? day;
  @JsonKey(name: "min")
  final double? min;
  @JsonKey(name: "max")
  final double? max;
  @JsonKey(name: "night")
  final double? night;
  @JsonKey(name: "eve")
  final double? eve;
  @JsonKey(name: "morn")
  final double? morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  Temp copyWith({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) =>
      Temp(
        day: day ?? this.day,
        min: min ?? this.min,
        max: max ?? this.max,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);

  Map<String, dynamic> toJson() => _$TempToJson(this);
}

@JsonSerializable()
class Weather {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "main")
  final String? main;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "icon")
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}