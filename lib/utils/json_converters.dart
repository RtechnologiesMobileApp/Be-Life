import 'package:json_annotation/json_annotation.dart';

class BoolFromIntConverter implements JsonConverter<bool, dynamic> {
  const BoolFromIntConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is bool) return json;
    if (json is int) return json == 1;
    return false;
  }

  @override
  dynamic toJson(bool object) => object;
}
