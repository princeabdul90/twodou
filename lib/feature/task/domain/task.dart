/*
* Developer: Abubakar Abdullahi
* Date: 17/10/2022
*/


import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final int? categoryId;
  final String? content;
  final String? datetime;
  final String? note;
  final int? status;

  const Task({
    this.id,
    this.categoryId,
    this.content,
    this.datetime,
    this.note,
    this.status,
  });

  @override
  List<Object?> get props => [id, categoryId, content, datetime, note, status];

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['taskId'],
    categoryId: json['categoryId'],
    content: json['content'],
    datetime: json['datetime'],
    note: json['note'],
    status: json['status'],
  );

  Map<String, dynamic> toJson() => {
    'taskId': id,
    'categoryId': categoryId,
    'content': content,
    'datetime': datetime,
    'note': note,
    'status': status
  };
}
