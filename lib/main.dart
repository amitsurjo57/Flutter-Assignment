import 'package:flutter/material.dart';
import 'Total Amount/total_amount.dart';
import 'package:provider/provider.dart';
import 'Total Amount/total_amount_count.dart';
import 'Total Amount/total_amount_list.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TotalAmount()),
        ChangeNotifierProvider(create: (context) => TotalAmountList()),
        ChangeNotifierProvider(create: (context) => TotalAmountCount()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
