// ignore_for_file: camel_case_types

import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/type/login_type.dart';
import 'package:map_together/model/type/os_type.dart';
import 'package:map_together/model/type/user_type.dart';

part 'login.g.dart';

@JsonSerializable()
class Login{
  String? loginId;
  String? password;
  UserType? userType;
  LoginType? loginType;
  OsType? osType;
  String? appVersion;
  int? osVersion;
  String? deviceId;


  Login({
    this.loginId,
    this.password,
    this.userType,
    this.loginType,
    this.osType,
    this.appVersion,
    this.osVersion,
    this.deviceId,
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}