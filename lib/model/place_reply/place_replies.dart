import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/place_reply/place_reply_simple.dart';

part 'place_replies.g.dart';

@JsonSerializable()
class PlaceReplies {
  List<PlaceReplySimple> list;
  int totalCount;
  bool last;
  
  PlaceReplies({
    required this.list,
    required this.totalCount,
    required this.last
  });

  factory PlaceReplies.fromJson(Map<String, dynamic> json) => _$PlaceRepliesFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceRepliesToJson(this);
}