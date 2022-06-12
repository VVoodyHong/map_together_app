import 'package:json_annotation/json_annotation.dart';

part 'place_reply_create.g.dart';

@JsonSerializable()
class PlaceReplyCreate {
  String reply;
  int placeIdx;
  
  PlaceReplyCreate({
    required this.reply,
    required this.placeIdx
  });

  factory PlaceReplyCreate.fromJson(Map<String, dynamic> json) => _$PlaceReplyCreateFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceReplyCreateToJson(this);
}