// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) {
  return Language(
    iso6391: json['iso6391'] as String,
    iso6392: json['iso6392'] as String,
    name: json['name'] as String,
    nativeName: json['nativeName'] as String,
  );
}

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'iso6391': instance.iso6391,
      'iso6392': instance.iso6392,
      'name': instance.name,
      'nativeName': instance.nativeName,
    };
