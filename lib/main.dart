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
          primary: Color(0xFFF2D3BE),
          secondary: Color(0xFFF5A882),
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.grey.shade800,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFF5A882),
        )
      ),
      home: const HomeScreen(),
    );
  }
}
