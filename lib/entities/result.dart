import 'package:json_annotation/json_annotation.dart';

part 'result.g.dart';

@JsonSerializable()
class Result extends Object{

  @JsonKey()
  final int code;
  @JsonKey()
  final String msg;
  @JsonKey()
  final Object data;

  Result(this.code, this.msg, this.data);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  @override
  String toString() {
    return 'Result{code: $code, msg: $msg, data: $data}';
  }


}