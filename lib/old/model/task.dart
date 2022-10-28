/*
* Developer: Abubakar Abdullahi
* Date: 06/08/2022
*/

import 'package:equatable/equatable.dart';
import 'category.dart';


class Task extends Equatable {
  final int? id;
  final int? categoryId;
  final String? content;
  //String? dateTime;
  final String? note;
  final int? status;

  const Task({
    this.id,
    required this.categoryId,
    required this.content,
    //required this.dateTime,
    required this.note,
    this.status = 0,
  });

  @override
  List<Object?> get props => [categoryId, content, note, status];

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['taskId'],
        categoryId: json['catId'],
        content: json['content'],
        //dateTime: json['dateTime'],
        note: json['note'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'taskId': id,
        'catId': categoryId,
        'content': content,
       // 'dateTime': dateTime,
        'note': note,
        'status': status
      };
}
