/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/

import 'package:equatable/equatable.dart';


class Category extends Equatable {
  final int? id;
  final String? title;
  final int? taskCount;
  final String? color;
  final String? icon;

  const Category({
    this.id, this.taskCount, this.title, this.color, this.icon,
  });

  @override
  List<Object?> get props => [id, title, taskCount, color, icon];


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

String getTaskCount(tasks) {
  if (tasks == 0) {
    return '0 Task';
  }
  return tasks.toString() + ' Tasks';
}

int getColor(String? color) {
  return int.parse(color!);
}