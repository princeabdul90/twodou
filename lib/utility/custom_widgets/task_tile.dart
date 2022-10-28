/*
* Developer: Abubakar Abdullahi
* Date: 07/08/2022
*/

import 'package:flutter/material.dart';

import '../theme.dart';
import 'TaskCheckBox.dart';


class TaskTile extends StatelessWidget {
  final dynamic task;
  const TaskTile({Key? key, required this.task}) : super(key: key);

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
              Text(task.content, style: TwoDouTheme.globalTextTheme.headline2,),
              Text(task.note, style: TwoDouTheme.globalTextTheme.bodyText2,),
            ],
          ),
          
          const TaskCheckBox(value: true),

        ],
      ),
    );
  }
}
