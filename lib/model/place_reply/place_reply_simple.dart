import 'package:json_annotation/json_annotation.dart';

part 'place_reply_simple.g.dart';

@JsonSerializable()
class PlaceReplySimple {
  int idx;
  String reply;
  int userIdx;
  String userNickname;
  String? userProfileImg;
  DateTime createAt;
  DateTime updateAt;
  
  PlaceReplySimple({
    required this.idx,
    required this.reply,
    required this.userIdx,
    required this.userNickname,
    this.userProfileImg,
    required this.createAt,
    required this.updateAt,
  });

  factory PlaceReplySimple.fromJson(Map<String, dynamic> json) => _$PlaceReplySimpleFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceReplySimpleToJson(this);
}