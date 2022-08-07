/*
* Developer: Abubakar Abdullahi
* Date: 07/08/2022
*/

import 'package:flutter/material.dart';
import 'package:twodou_app/ui/task/TaskCheckBox.dart';
import 'package:twodou_app/ui/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: const EdgeInsets.all(10.0),
      decoration:  BoxDecoration(
        // color: Colors.greenAccent,
        shape: BoxShape.rectangle,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100))
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Call Max', style: TwoDouTheme.globalTextTheme.headline2,),
              Text('17:00', style: TwoDouTheme.globalTextTheme.bodyText2,),
            ],
          ),
          
          const TaskCheckBox(value: false),

        ],
      ),
    );
  }
}
