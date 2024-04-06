import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class Address {
  final int id;
  final String value;

  Address({required this.id, required this.value});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  static List<Address> addressesFromJson(String str) {
    final decodedJson = json.decode(str);
    if (decodedJson is! List) {
      throw const FormatException('Expected a JSON list');
    }
    return decodedJson.map((x) => Address.fromJson(x as Map<String, dynamic>)).toList();
  }
}
