import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_home_mobile_app/product/converters/bigint_converter.dart';
import 'package:smart_home_mobile_app/product/enums/data_type.dart';

part 'ping_data_response.g.dart';

@immutable
@JsonSerializable()
class PingDataResponse extends Equatable {
  final DataType? type;
  @BigIntConverter()
  final BigInt? timestamp;

  const PingDataResponse({this.type, this.timestamp});

  @override
  List<Object?> get props => [type, timestamp];

  PingDataResponse copyWith({
    DataType? type,
    BigInt? timestamp,
  }) {
    return PingDataResponse(
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
    );
  }
  factory PingDataResponse.fromJson(Map<String, dynamic> json) {
    return _$PingDataResponseFromJson(json);
  }
}
