import 'package:json_annotation/json_annotation.dart';

part 'sys.g.dart';

@JsonSerializable()
class Sys {
  @JsonKey(name: "type")
  final int? type;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "sunrise")
  final int? sunrise;
  @JsonKey(name: "sunset")
  final int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) =>
      Sys(
        type: type ?? this.type,
        id: id ?? this.id,
        country: country ?? this.country,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );

  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);
}
