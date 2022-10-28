/*
* Developer: Abubakar Abdullahi
* Date: 08/08/2022
*/

import 'package:flutter/material.dart';

import '../colors.dart';

class CustomChoiceChip extends StatefulWidget {
  final String label;
  const CustomChoiceChip({Key? key, required this.label}) : super(key: key);

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  var _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.label),
      labelStyle: const TextStyle(color: Colors.white),
      selected: _isSelected,
      selectedColor: blue,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
    );
  }
}
