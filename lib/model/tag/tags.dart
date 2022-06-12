import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/tag/tag.dart';

part 'tags.g.dart';

@JsonSerializable()
class Tags {
  List<Tag> list;
  
  Tags({
    required this.list
  });

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
  Map<String, dynamic> toJson() => _$TagsToJson(this);
}