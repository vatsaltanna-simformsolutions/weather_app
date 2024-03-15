import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

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

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
