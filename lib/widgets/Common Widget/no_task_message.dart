import 'package:flutter/material.dart';

class NoTaskMessage extends StatelessWidget {
  const NoTaskMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text('There is no Task'),
      ),
    );
  }
}
