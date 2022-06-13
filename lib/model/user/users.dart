import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/user/user_simple.dart';

part 'users.g.dart';

@JsonSerializable()
class Users {
  List<UserSimple> list;
  int totalCount;
  bool last;
  
  Users({
    required this.list,
    required this.totalCount,
    required this.last
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);
}