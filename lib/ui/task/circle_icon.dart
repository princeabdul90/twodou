/*
* Developer: Abubakar Abdullahi
* Date: 07/08/2022
*/

import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final double imageRadius;
  final Widget? icon;
  const CircleIcon({
    Key? key,
    required this.icon,
    this.imageRadius = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: imageRadius,
      child: icon
    );
  }
}
