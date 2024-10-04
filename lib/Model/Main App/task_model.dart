

import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final String subTitle;
  final String date;
  final String status;
  final Color statusColor;
  final void Function()? onEdit;
  final void Function()? onDelete;

  TaskModel({
    required this.title,
    required this.subTitle,
    required this.date,
    required this.status,
    required this.statusColor,
    this.onEdit,
    this.onDelete,
  });
}
