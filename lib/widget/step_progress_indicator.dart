import 'package:flutter/material.dart';
import 'package:map_together/utils/constants.dart';

class StepProgressIndicator extends StatelessWidget {

  final int currentLevel;
  final int totalLevel;

  StepProgressIndicator({
    required this.currentLevel,
    required this.totalLevel
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _stepItem()
    );
  }

  List<Widget> _stepItem() {
    List<Widget> list = [];
    for (int i = 0; i < totalLevel; i++) {
      list.add(
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i < currentLevel ? MtColor.signature : MtColor.paleGrey
          ),
          child: Text(
            (i + 1).toString(),
            style: TextStyle(
              fontSize: 18,
              color: i < currentLevel ? MtColor.white : MtColor.grey
            ),
          ),
        )
      );
      if(i < totalLevel - 1) {
        list.add(
          Expanded(
            child: Container(
              width: 1,
              height: 1,
              color: MtColor.paleGrey,
            ),
          )
        );
      }
    }
    return list;
  }
}