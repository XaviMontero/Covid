// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Infect _$InfectFromJson(Map<String, dynamic> json) {
  return Infect(
    country: json['country'] as String,
    cases: json['cases'] as int,
    todayCases: json['todayCases'] as int,
    deaths: json['deaths'] as int,
    todayDeaths: json['todayDeaths'] as int,
    recovered: json['recovered'] as int,
    active: json['active'] as int,
    critical: json['critical'] as int,
  );
}

Map<String, dynamic> _$InfectToJson(Infect instance) => <String, dynamic>{
      'country': instance.country,
      'cases': instance.cases,
      'todayCases': instance.todayCases,
      'deaths': instance.deaths,
      'todayDeaths': instance.todayDeaths,
      'recovered': instance.recovered,
      'active': instance.active,
      'critical': instance.critical,
    };
