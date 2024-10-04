import 'package:flutter/material.dart';
import 'package:greeting_app/Model/Main%20App/task_model.dart';
import 'package:greeting_app/screens/Main%20Body/create_new_task_screen.dart';
import 'package:greeting_app/widgets/Main%20App/counting_card.dart';
import 'package:greeting_app/widgets/Main%20App/task_widget.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(context),
      body: Column(
        children: [
          countingHeader(),
          mainTasks(context),
        ],
      ),
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _onTapCreateTask(context),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: const Icon(Icons.add, size: 32),
    );
  }

  Widget countingHeader() {
    return const Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CountingCard(
              numberOfTask: 09,
              task: 'Canceled',
            ),
            CountingCard(
              numberOfTask: 09,
              task: 'Completed',
            ),
            CountingCard(
              numberOfTask: 09,
              task: 'Progress',
            ),
            CountingCard(
              numberOfTask: 09,
              task: 'New Task',
            ),
          ],
        ),
      ),
    );
  }

  Expanded mainTasks(BuildContext context) {
    return Expanded(
      child: TaskWidget(
        itemCount: 10,
        taskModel: TaskModel(
          title: 'This is title',
          subTitle: 'This is subTitle',
          date: '04/10/2024',
          status: 'New',
          statusColor: Colors.blue,
          onEdit: () => _onTapEdit(context),
          onDelete: () {
            // TODO: On delete Task
          },
        ),
      ),
    );
  }

  void _onTapEdit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
              return ListTile(
                onTap: () {
                  // TODO: On Tap in Task Status
                },
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
              onPressed: () {
                // TODO: On Edit Okay
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  void _onTapCreateTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNewTaskScreen(),
      ),
    );
  }
}
