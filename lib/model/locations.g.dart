// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      generationtimeMs: (json['generationtime_ms'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'results': instance.results,
      'generationtime_ms': instance.generationtimeMs,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as int?,
      name: json['name'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      elevation: (json['elevation'] as num?)?.toDouble(),
      featureCode: json['feature_code'] as String?,
      countryCode: json['country_code'] as String?,
      admin1Id: json['admin1_id'] as int?,
      timezone: json['timezone'] as String?,
      population: json['population'] as int?,
      countryId: json['country_id'] as int?,
      country: json['country'] as String?,
      admin1: json['admin1'] as String?,
      admin2Id: json['admin2_id'] as int?,
      admin2: json['admin2'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'elevation': instance.elevation,
      'feature_code': instance.featureCode,
      'country_code': instance.countryCode,
      'admin1_id': instance.admin1Id,
      'timezone': instance.timezone,
      'population': instance.population,
      'country_id': instance.countryId,
      'country': instance.country,
      'admin1': instance.admin1,
      'admin2_id': instance.admin2Id,
      'admin2': instance.admin2,
    };
