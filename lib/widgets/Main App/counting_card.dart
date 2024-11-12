import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_counter_model.dart';

class CountingCard extends StatelessWidget {
  final TaskCounterModel model;

  const CountingCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.taskNumber,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                model.taskName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
