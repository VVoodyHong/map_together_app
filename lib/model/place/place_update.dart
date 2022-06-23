import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/file/file.dart';
import 'package:map_together/model/tag/tag.dart';

part 'place_update.g.dart';

@JsonSerializable()
class PlaceUpdate {
  int idx;
  int categoryIdx;
  String name;
  String address;
  String? description;
  List<Tag> addTags;
  List<Tag> deleteTags;
  List<File> deleteFiles;
  double favorite;
  double lat;
  double lng;
  
  PlaceUpdate({
    required this.idx,
    required this.categoryIdx,
    required this.name,
    required this.address,
    this.description,
    required this.addTags,
    required this.deleteTags,
    required this.deleteFiles,
    required this.favorite,
    required this.lat,
    required this.lng
  });

  factory PlaceUpdate.fromJson(Map<String, dynamic> json) => _$PlaceUpdateFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceUpdateToJson(this);
}