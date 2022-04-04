import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/btn_profile.dart';

class Profile extends StatelessWidget {

  // Profile({

  // });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Row(
            children: [
              ClipOval(
                child: SizedBox(
                  height: 110,
                  width: 110,
                  child: Image.asset(
                    Asset.profile,
                    fit: BoxFit.cover
                  ),
                )
              ),
              Expanded(
                child: Container(
                  height: 110,
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 5 ),
                        child: Text(
                          '홍정욱',
                          style: TextStyle(
                            fontSize: FontSize.large,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '반갑습니다😄\n나만의 여행일지✈\nhju4287@naver.com',
                          style: TextStyle(
                            height: 1.3
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: MtColor.paleGrey,
                width: 0.5
              )
            )
          ),
          child: Row(
            children: [
              BtnProfile(
                title: 'place',
                number: '0'
              ),
              BtnProfile(
                title: 'following',
                number: '0'
              ),
              BtnProfile(
                title: 'follower',
                number: '0'
              ),
            ],
          ),
        )
      ],
    );
  }
}
