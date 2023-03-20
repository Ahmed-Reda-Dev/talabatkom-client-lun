// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'data.dart';

class UserBalance {
  bool? success;
  Data? data;
  String? message;

  UserBalance({this.success, this.data, this.message});

  factory UserBalance.fromJson(Map<String, dynamic> json) => UserBalance(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'message': message,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserBalance) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode ^ message.hashCode;
}
