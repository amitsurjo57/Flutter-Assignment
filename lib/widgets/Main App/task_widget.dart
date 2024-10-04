import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel taskModel;
  final int itemCount;

  const TaskWidget({
    super.key,
    required this.taskModel,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: itemCount,
        itemBuilder: (context, index) => Card(
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
      ),
    );
  }
}
