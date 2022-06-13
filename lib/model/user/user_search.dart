import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/page/request_page.dart';

part 'user_search.g.dart';

@JsonSerializable()
class UserSearch {
  String keyword;
  RequestPage requestPage;
  
  UserSearch({
    required this.keyword,
    required this.requestPage
  });

  factory UserSearch.fromJson(Map<String, dynamic> json) => _$UserSearchFromJson(json);
  Map<String, dynamic> toJson() => _$UserSearchToJson(this);
}