import 'package:json_annotation/json_annotation.dart';

part 'translations.g.dart';

@JsonSerializable(explicitToJson: true)
class Translations {
  String de;
  String es;
  String fr;
  String ja;
  String it;
  String br;
  String pt;
  String nl;
  String hr;
  String fa;

  Translations({
    this.de,
    this.es,
    this.fr,
    this.ja,
    this.it,
    this.br,
    this.pt,
    this.nl,
    this.hr,
    this.fa,
  });
    factory Translations.fromJson(Map<String, dynamic> json) => _$TranslationsFromJson(json);
  Map<String, dynamic> toJson() => _$TranslationsToJson(this);
}
