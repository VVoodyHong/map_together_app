import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/type/file_type.dart';

part 'file.g.dart';

@JsonSerializable()
class File {
  int idx;
  String? name;
  FileType? type;
  String url;
  
  File({
    required this.idx,
    this.name,
    this.type,
    required this.url
  });

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);
  Map<String, dynamic> toJson() => _$FileToJson(this);
}