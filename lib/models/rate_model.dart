import 'dart:convert';

RateModel rateModelFromJson(String str) => RateModel.fromJson(json.decode(str));

String rateModelToJson(RateModel data) => json.encode(data.toJson());

class RateModel {
  String disclaimer;
  String license;
  int timestamp;
  String base;
  Map<String, double> rate;

  RateModel({
    required this.disclaimer,
    required this.license,
    required this.timestamp,
    required this.base,
    required this.rate,
  });

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
        disclaimer: json["disclaimer"],
        license: json["license"],
        timestamp: json["timestamp"],
        base: json["base"],
        rate: Map.from(json["rate"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer,
        "license": license,
        "timestamp": timestamp,
        "base": base,
        "rate": Map.from(rate).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
