import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF82D1F1),
          secondary: Colors.cyanAccent,
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.grey.shade800,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          // color: Color(0xFFF5A882),
          color: Colors.lightBlueAccent,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
