import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/model/coord.dart';

part 'city.g.dart';

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
