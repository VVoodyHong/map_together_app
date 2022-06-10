import 'package:json_annotation/json_annotation.dart';
import 'package:map_together/model/file/file.dart';

part 'files.g.dart';

@JsonSerializable()
class Files {
  List<File> list;
  
  Files({
    required this.list
  });

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);
  Map<String, dynamic> toJson() => _$FilesToJson(this);
}