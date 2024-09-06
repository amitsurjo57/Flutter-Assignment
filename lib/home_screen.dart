import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Shirt/shirt_list.dart';
import 'Shirt/t_shirt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, amountModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Bag",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomSheet: SizedBox(
          width: double.infinity,
          child: BottomAppBar(
            elevation: 100,
            height: 108,
            color: Colors.white,
            shadowColor: Colors.grey,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total amount:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '0\$',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Congratulation !!!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('CHECK OUT'),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 24),
          itemCount: shirtList.length,
          itemBuilder: (context, index) {
            return TShirt(
              imagePath: shirtList[index].imagePath,
              shirtType: shirtList[index].shirtType,
              shirtColor: shirtList[index].shirtColor,
              shirtSize: shirtList[index].shirtSize,
              shirtPrice: shirtList[index].shirtPrice,
            );
          },
        ),
      ),
    );
  }
}
