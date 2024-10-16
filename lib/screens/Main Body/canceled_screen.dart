import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class CanceledScreen extends StatelessWidget {
  const CanceledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskWidget(
        taskModel: TaskModel(
          title: 'This is title',
          subTitle: 'This is subTitle',
          date: '04/10/2024',
          status: 'Cancelled',
          statusColor: Colors.red,
          onEdit: () => _onTapEdit(context),
          onDelete: () {},
        ),
      ),
    );
  }

  _onTapEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
              return ListTile(
                onTap: () {},
                title: Text(e),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }
}
