import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/place/place.dart';
import 'package:map_together/model/user/user.dart';

part 'place_reply.g.dart';

@JsonSerializable()
class PlaceReply {
  int idx;
  String reply;
  Place place;
  User user;
  DateTime createAt;
  DateTime updateAt;
  
  PlaceReply({
    required this.idx,
    required this.reply,
    required this.place,
    required this.user,
    required this.createAt,
    required this.updateAt,
  });

  factory PlaceReply.fromJson(Map<String, dynamic> json) => _$PlaceReplyFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceReplyToJson(this);
}