import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Main%20Body/create_new_task_screen.dart';
import 'package:greeting_app/widgets/Main%20App/counting_card.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTapCreateTask(context),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add, size: 32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            countingHeader(),
          ],
        ),
      ),
    );
  }

  Widget countingHeader() {
    return const SingleChildScrollView(
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
