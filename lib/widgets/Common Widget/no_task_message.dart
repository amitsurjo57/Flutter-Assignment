import 'package:flutter/material.dart';

class NoTaskMessage extends StatelessWidget {
  final Future<void> Function()? refresh;

  const NoTaskMessage({super.key, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'There is no Task',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: refresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[50],
            ),
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}
