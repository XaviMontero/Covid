import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable(explicitToJson: true)
class Currency {
  String code;
  String name;
  String symbol;

  Currency({
    this.code,
    this.name,
    this.symbol,
  });
     factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

