import 'package:json_annotation/json_annotation.dart';

part 'day_temperature.g.dart';

@JsonSerializable()
class DayTemperature {
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

  DayTemperature({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  DayTemperature copyWith({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) =>
      DayTemperature(
        day: day ?? this.day,
        min: min ?? this.min,
        max: max ?? this.max,
        night: night ?? this.night,
        eve: eve ?? this.eve,
        morn: morn ?? this.morn,
      );

  factory DayTemperature.fromJson(Map<String, dynamic> json) =>
      _$DayTemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$DayTemperatureToJson(this);
}
