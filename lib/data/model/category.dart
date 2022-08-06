/*
* Developer: Abubakar Abdullahi
* Date: 03/08/2022
*/

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  int? id;
  final String? title;
  final int? taskCount;
  final String? color;
  final String? icon;

  Category({
    this.id,
    required this.taskCount,
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  List<Object?> get props => [title, taskCount, color, icon];

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['categoryId'],
        taskCount: json['taskCount'],
        title: json['title'],
        color: json['color'],
        icon: json['icon'],
      );

  Map<String, dynamic> toJson() => {
        'categoryId': id,
        'taskCount': taskCount,
        'title': title,
        'color': color,
        'icon': icon,
      };
}

String getTaskCount(int? tasks) {
  if (tasks == null) {
    return '0 tasks';
  }
  return tasks.toString() + ' tasks';
}

int getColor(String? color) {
  return int.parse(color!);
}