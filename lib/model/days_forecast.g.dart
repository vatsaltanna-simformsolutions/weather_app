// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'days_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DaysForecast _$DaysForecastFromJson(Map<String, dynamic> json) => DaysForecast(
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      cod: json['cod'] as String?,
      message: (json['message'] as num?)?.toDouble(),
      cnt: json['cnt'] as int?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => DayWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DaysForecastToJson(DaysForecast instance) =>
    <String, dynamic>{
      'city': instance.city,
      'cod': instance.cod,
      'message': instance.message,
      'cnt': instance.cnt,
      'list': instance.list,
    };
