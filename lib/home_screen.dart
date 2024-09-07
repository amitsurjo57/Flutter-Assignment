import 'package:flutter/material.dart';
import 'package:ostad_flutter_assignment/custom_widget/custom_shirt_widget.dart';
import 'Shirt/shirt_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int pullOverPiece = 1;
  int tShirtPiece = 1;
  int sportDressPiece = 1;

  int pullOverAmount = shirtList[0].shirtPrice * 1;
  int tShirtAmount = shirtList[1].shirtPrice * 1;
  int sportDressAmount = shirtList[2].shirtPrice * 1;

  int totalAmount = shirtList[0].shirtPrice +
      shirtList[1].shirtPrice +
      shirtList[2].shirtPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bag",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomSheet: bottomSheet(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            pullOverShirt(),
            const SizedBox(height: 32),
            tShirt(),
            const SizedBox(height: 32),
            sportDress(),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BottomAppBar(
        elevation: 100,
        height: 108,
        color: Colors.white,
        shadowColor: Colors.grey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total amount:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '$totalAmount\$',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Congratulation !!!'),
                  ),
                ),
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
    );
  }

  Widget pullOverShirt() {
    return ShirtWidget(
      imagePath: shirtList[0].imagePath,
      shirtType: shirtList[0].shirtType,
      shirtColor: shirtList[0].shirtColor,
      shirtSize: shirtList[0].shirtSize,
      shirtPrice: shirtList[0].shirtPrice,
      incrementPiece: () {
        setState(() {
          pullOverPiece++;
          pullOverAmount = shirtList[0].shirtPrice * pullOverPiece;
          calTotalAmount();
        });
      },
      decrementPiece: () {
        setState(() {
          pullOverPiece <= 0 ? null : pullOverPiece--;
          pullOverAmount = shirtList[0].shirtPrice * pullOverPiece;
          calTotalAmount();
        });
      },
      shirtPiece: pullOverPiece,
      shirtPriceTotal: pullOverAmount,
    );
  }

  Widget tShirt() {
    return ShirtWidget(
      imagePath: shirtList[1].imagePath,
      shirtType: shirtList[1].shirtType,
      shirtColor: shirtList[1].shirtColor,
      shirtSize: shirtList[1].shirtSize,
      shirtPrice: shirtList[1].shirtPrice,
      incrementPiece: () {
        setState(() {
          tShirtPiece++;
          tShirtAmount = shirtList[1].shirtPrice * tShirtPiece;
          calTotalAmount();
        });
      },
      decrementPiece: () {
        setState(() {
          tShirtPiece <= 0 ? null : tShirtPiece--;
          tShirtAmount = shirtList[1].shirtPrice * tShirtPiece;
          calTotalAmount();
        });
      },
      shirtPiece: tShirtPiece,
      shirtPriceTotal: tShirtAmount,
    );
  }

  Widget sportDress() {
    return ShirtWidget(
      imagePath: shirtList[2].imagePath,
      shirtType: shirtList[2].shirtType,
      shirtColor: shirtList[2].shirtColor,
      shirtSize: shirtList[2].shirtSize,
      shirtPrice: shirtList[2].shirtPrice,
      incrementPiece: () {
        setState(() {
          sportDressPiece++;
          sportDressAmount = shirtList[2].shirtPrice * sportDressPiece;
          calTotalAmount();
        });
      },
      decrementPiece: () {
        setState(() {
          sportDressPiece <= 0 ? null : sportDressPiece--;
          sportDressAmount = shirtList[2].shirtPrice * sportDressPiece;
          calTotalAmount();
        });
      },
      shirtPiece: sportDressPiece,
      shirtPriceTotal: sportDressAmount,
    );
  }

  void calTotalAmount() {
    totalAmount = pullOverAmount + tShirtAmount + sportDressAmount;
  }
}
