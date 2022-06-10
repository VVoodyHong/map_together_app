import 'package:json_annotation/json_annotation.dart';

enum FileType{
  //doc type
  @JsonValue('pdf') pdf,
  @JsonValue('doc') doc,
  @JsonValue('docx') docx,
  @JsonValue('xls') xls,
  @JsonValue('xlsx') xlsx,
  @JsonValue('ppt') ppt,
  @JsonValue('pptx') pptx,

  //image type
  @JsonValue('bmp') bmp,
  @JsonValue('jpg') jpg,
  @JsonValue('png') png,
  @JsonValue('gif') gif,
  @JsonValue('ico') ico,

  //video type
  @JsonValue('avi') avi,
  @JsonValue('mpg') mpg,
  @JsonValue('mp4') mp4,
  @JsonValue('wmv') wmv,
  @JsonValue('mov') mov,
  @JsonValue('flv') flv,
  @JsonValue('swf') swf,
  @JsonValue('mkv') mkv,

  unknown
}