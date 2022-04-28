import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class KakaoAccount{
  int? id;
  String? connectedAt;
  Map<String, dynamic>? kakaoAccount;

  KakaoAccount(
    {
      this.id,
      this.connectedAt,
      this.kakaoAccount
    }
  );

  factory KakaoAccount.fromJson(Map<String, dynamic> json){
    return KakaoAccount(
      id: json['id'] as int?,
      connectedAt: json['connected_at'] as String?,
      kakaoAccount: json['kakao_account'] as Map<String, dynamic>?,
    );
  }
}