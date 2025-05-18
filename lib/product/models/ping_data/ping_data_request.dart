import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_home_mobile_app/product/enums/data_type.dart';

part 'ping_data_request.g.dart';

@immutable
@JsonSerializable()
class PingDataRequest extends Equatable {
  final DataType? type;
  final int? timestamp;

  const PingDataRequest({this.type, this.timestamp});

  factory PingDataRequest.instance(){
    return PingDataRequest(type: DataType.ping,timestamp: DateTime.now().millisecondsSinceEpoch);
  }

  @override
  List<Object?> get props => [type, timestamp];

  PingDataRequest copyWith({
    DataType? type,
    int? timestamp,
  }) {
    return PingDataRequest(
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
    );
  }
  Map<String, dynamic> toJson() {
    return _$PingDataRequestToJson(this);
  }
}
