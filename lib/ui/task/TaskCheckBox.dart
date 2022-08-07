/*
* Developer: Abubakar Abdullahi
* Date: 07/08/2022
*/

import 'package:flutter/material.dart';

class TaskCheckBox extends StatelessWidget {
  final Function(bool?)? onComplete;
  final dynamic value;

  const TaskCheckBox({Key? key, required this.value,  this.onComplete, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: value, onChanged: onComplete);
  }
}
