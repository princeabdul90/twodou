/*
* Developer: Abubakar Abdullahi
* Date: 06/08/2022
*/

import 'package:equatable/equatable.dart';
import 'category.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  int? id;
  Category? catId;
  String? content;
  DateTime? dateTime;
  String? note;
  bool? status;

  Task({
    this.id,
    required this.catId,
    required this.content,
    required this.dateTime,
    required this.note,
    required this.status,
  });

  @override
  List<Object?> get props => [catId, content, dateTime, note, status];

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['taskId'],
        catId: json['catId'],
        content: json['content'],
        dateTime: json['dateTime'],
        note: json['note'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'taskId': id,
        'catId': catId,
        'content': content,
        'dateTime': dateTime,
        'note': note,
        'status': status
      };
}
