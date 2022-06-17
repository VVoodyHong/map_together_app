import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/page/request_page.dart';
import 'package:map_together/model/type/follow_type.dart';

part 'follow_search.g.dart';

@JsonSerializable()
class FollowSearch {
  String keyword;
  RequestPage requestPage;
  FollowType followType;
  int userIdx;
  
  FollowSearch({
    required this.keyword,
    required this.requestPage,
    required this.followType,
    required this.userIdx,
  });

  factory FollowSearch.fromJson(Map<String, dynamic> json) => _$FollowSearchFromJson(json);
  Map<String, dynamic> toJson() => _$FollowSearchToJson(this);
}