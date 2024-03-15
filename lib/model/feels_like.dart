import 'package:json_annotation/json_annotation.dart';

part 'feels_like.g.dart';

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

  factory FeelsLike.fromJson(Map<String, dynamic> json) =>
      _$FeelsLikeFromJson(json);

  Map<String, dynamic> toJson() => _$FeelsLikeToJson(this);
}
