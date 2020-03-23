
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable(explicitToJson: true)
class Language {
  String iso6391;
  String iso6392;
  String name;
  String nativeName;

  Language({
    this.iso6391,
    this.iso6392,
    this.name,
    this.nativeName,
  });
       factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
