import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'name')
enum DataType {
  ping("ping"),
  pong("pong"),
  control("control"),
  status("status");

  const DataType(this.name);

  final String name;
}
