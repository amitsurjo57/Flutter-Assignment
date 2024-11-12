import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Main%20Body/canceled_screen.dart';
import 'package:greeting_app/screens/Main%20Body/completed_screen.dart';
import 'package:greeting_app/screens/Main%20Body/new_task_screen.dart';
import 'package:greeting_app/screens/Main%20Body/progress_screen.dart';
import 'package:greeting_app/utils/common_color.dart';
import 'package:greeting_app/widgets/Main%20App/tam_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  List listScreen = const [
    NewTaskScreen(),
    CompletedScreen(),
    CanceledScreen(),
    ProgressTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TamAppbar(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        surfaceTintColor: CommonColor.commonColor,
        indicatorColor: CommonColor.commonColor.withOpacity(0.3),
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task_rounded),
            label: 'New Task',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_rounded),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Canceled',
          ),
          NavigationDestination(
            icon: Icon(Icons.refresh),
            label: 'Progress',
          ),
        ],
      ),
      body: listScreen[_selectedIndex],
    );
  }
}
