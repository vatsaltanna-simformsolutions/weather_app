// To parse this JSON data, do
//
//     final locations = locationsFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'locations.g.dart';

Locations locationsFromJson(String str) => Locations.fromJson(json.decode(str));

String locationsToJson(Locations data) => json.encode(data.toJson());

@JsonSerializable()
class Locations {
  @JsonKey(name: "results")
  final List<Result>? results;
  @JsonKey(name: "generationtime_ms")
  final double? generationtimeMs;

  Locations({
    this.results,
    this.generationtimeMs,
  });

  Locations copyWith({
    List<Result>? results,
    double? generationtimeMs,
  }) =>
      Locations(
        results: results ?? this.results,
        generationtimeMs: generationtimeMs ?? this.generationtimeMs,
      );

  factory Locations.fromJson(Map<String, dynamic> json) => _$LocationsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "elevation")
  final double? elevation;
  @JsonKey(name: "feature_code")
  final String? featureCode;
  @JsonKey(name: "country_code")
  final String? countryCode;
  @JsonKey(name: "admin1_id")
  final int? admin1Id;
  @JsonKey(name: "timezone")
  final String? timezone;
  @JsonKey(name: "population")
  final int? population;
  @JsonKey(name: "country_id")
  final int? countryId;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "admin1")
  final String? admin1;
  @JsonKey(name: "admin2_id")
  final int? admin2Id;
  @JsonKey(name: "admin2")
  final String? admin2;

  Result({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.elevation,
    this.featureCode,
    this.countryCode,
    this.admin1Id,
    this.timezone,
    this.population,
    this.countryId,
    this.country,
    this.admin1,
    this.admin2Id,
    this.admin2,
  });

  Result copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    double? elevation,
    String? featureCode,
    String? countryCode,
    int? admin1Id,
    String? timezone,
    int? population,
    int? countryId,
    String? country,
    String? admin1,
    int? admin2Id,
    String? admin2,
  }) =>
      Result(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        elevation: elevation ?? this.elevation,
        featureCode: featureCode ?? this.featureCode,
        countryCode: countryCode ?? this.countryCode,
        admin1Id: admin1Id ?? this.admin1Id,
        timezone: timezone ?? this.timezone,
        population: population ?? this.population,
        countryId: countryId ?? this.countryId,
        country: country ?? this.country,
        admin1: admin1 ?? this.admin1,
        admin2Id: admin2Id ?? this.admin2Id,
        admin2: admin2 ?? this.admin2,
      );

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}