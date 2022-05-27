import 'package:json_annotation/json_annotation.dart';

part 'user_update.g.dart';

@JsonSerializable()
class UserUpdate {
  final String? nickname;
  
  UserUpdate({
    this.nickname
  });

  factory UserUpdate.fromJson(Map<String, dynamic> json) => _$UserUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateToJson(this);
}