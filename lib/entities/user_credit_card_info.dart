import 'package:json_annotation/json_annotation.dart';
import 'check_in_detail_info.dart';
part 'user_credit_card_info.g.dart';

@JsonSerializable()
class UserCreditCardInfo extends Object {

  @JsonKey()
  int id;
  @JsonKey()
  int userId;
  @JsonKey()
  bool master;
  @JsonKey()
  String number;
  @JsonKey()
  String expiryDate;
  @JsonKey()
  String cvv;
  @JsonKey()
  String firstName;
  @JsonKey()
  String lastName;
  @JsonKey()
  String zipCode;
  @JsonKey()
  String billAddress;
  @JsonKey()
  String createTime;
  @JsonKey()
  String modifyTime;

  factory UserCreditCardInfo.fromJson(Map<String, dynamic> json) => _$UserCreditCardInfoFromJson(json);

  UserCreditCardInfo(this.id, this.userId, this.master, this.number,
      this.expiryDate, this.cvv, this.firstName, this.lastName, this.zipCode,
      this.billAddress, this.createTime, this.modifyTime);

  @override
  String toString() {
    return 'UserCreditCardInfo{id: $id, userId: $userId, master: $master, number: $number, expiryDate: $expiryDate, cvv: $cvv, firstName: $firstName, lastName: $lastName, zipCode: $zipCode, billAddress: $billAddress, createTime: $createTime, modifyTime: $modifyTime}';
  }


}