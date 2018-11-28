// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credit_card_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreditCardInfo _$UserCreditCardInfoFromJson(Map<String, dynamic> json) {
  return UserCreditCardInfo(
      json['id'] as int,
      json['userId'] as int,
      json['master'] as bool,
      json['number'] as String,
      json['expiryDate'] as String,
      json['cvv'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['zipCode'] as String,
      json['billAddress'] as String,
      json['createTime'] as String,
      json['modifyTime'] as String);
}

Map<String, dynamic> _$UserCreditCardInfoToJson(UserCreditCardInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'master': instance.master,
      'number': instance.number,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'zipCode': instance.zipCode,
      'billAddress': instance.billAddress,
      'createTime': instance.createTime,
      'modifyTime': instance.modifyTime
    };
