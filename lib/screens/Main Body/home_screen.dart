import 'package:flutter/material.dart';
import 'package:greeting_app/screens/Main%20Body/canceled_screen.dart';
import 'package:greeting_app/screens/Main%20Body/completed_screen.dart';
import 'package:greeting_app/screens/Main%20Body/task_screen.dart';
import 'package:greeting_app/screens/Main%20Body/progress_screen.dart';
import 'package:greeting_app/utils/common_color.dart';
import 'package:greeting_app/widgets/Main%20App/tam_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  List listScreen = const [
    TaskScreen(),
    CompletedScreen(),
    CanceledScreen(),
    ProgressScreen(),
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
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
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
      body: PageView.builder(
        controller: _pageController,
        itemCount: listScreen.length,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        itemBuilder: (context, index) => listScreen[index],
      ),
    );
  }
}
