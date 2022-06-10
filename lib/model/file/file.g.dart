// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      idx: json['idx'] as int,
      name: json['name'] as String?,
      type: $enumDecodeNullable(_$FileTypeEnumMap, json['type']),
      url: json['url'] as String,
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'idx': instance.idx,
      'name': instance.name,
      'type': _$FileTypeEnumMap[instance.type],
      'url': instance.url,
    };

const _$FileTypeEnumMap = {
  FileType.pdf: 'pdf',
  FileType.doc: 'doc',
  FileType.docx: 'docx',
  FileType.xls: 'xls',
  FileType.xlsx: 'xlsx',
  FileType.ppt: 'ppt',
  FileType.pptx: 'pptx',
  FileType.bmp: 'bmp',
  FileType.jpg: 'jpg',
  FileType.png: 'png',
  FileType.gif: 'gif',
  FileType.ico: 'ico',
  FileType.avi: 'avi',
  FileType.mpg: 'mpg',
  FileType.mp4: 'mp4',
  FileType.wmv: 'wmv',
  FileType.mov: 'mov',
  FileType.flv: 'flv',
  FileType.swf: 'swf',
  FileType.mkv: 'mkv',
  FileType.unknown: 'unknown',
};
