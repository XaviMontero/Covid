 
import 'package:json_annotation/json_annotation.dart';

part 'infect.g.dart';

@JsonSerializable()
class Infect {
  String country;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;

  Infect({
    this.country,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
  });
    factory Infect.fromJson(Map<String, dynamic> json) => _$InfectFromJson(json);
  Map<String, dynamic> toJson() => _$InfectToJson(this);

}

class Infects {
   List<Infect> items = new List();

 

  Infects.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final result = new Infect.fromJson(item);
      items.add(result);
    }
  }
  
}


