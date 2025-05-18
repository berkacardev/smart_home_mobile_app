import 'package:json_annotation/json_annotation.dart';

class BigIntConverter implements JsonConverter<BigInt?, dynamic> {
  const BigIntConverter();

  @override
  BigInt? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return BigInt.from(json);
    if (json is String) return BigInt.tryParse(json);
    return null;
  }

  @override
  dynamic toJson(BigInt? object) => object?.toString();
}
