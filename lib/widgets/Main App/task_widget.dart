import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskWidget({
    super.key,
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskModel.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                taskModel.subTitle,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Date: ${taskModel.date}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      taskModel.status,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: taskModel.statusColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: taskModel.statusColor),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: taskModel.onEdit,
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: taskModel.onDelete,
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
