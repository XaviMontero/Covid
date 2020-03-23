
import 'package:json_annotation/json_annotation.dart';

part 'regional_bloc.g.dart';

@JsonSerializable(explicitToJson: true)
class RegionalBloc {
  String acronym;
  String name;
  List<String> otherAcronyms;
  List<String> otherNames;
  String region; 

  RegionalBloc({
    this.acronym,
    this.name,
    this.otherAcronyms,
    this.otherNames,
  });
         factory RegionalBloc.fromJson(Map<String, dynamic> json) => _$RegionalBlocFromJson(json);
  Map<String, dynamic> toJson() => _$RegionalBlocToJson(this);
}
 