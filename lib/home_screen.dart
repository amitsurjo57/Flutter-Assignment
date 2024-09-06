import 'package:flutter/material.dart';
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
      bottomSheet: SizedBox(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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

  void calTotalAmount() {
    totalAmount = pullOverAmount + tShirtAmount + sportDressAmount;
  }

  Container sportDress() {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(shirtList[2].imagePath),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shirtList[2].shirtType,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Color: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: shirtList[2].shirtColor,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const TextSpan(text: '   '),
                    const TextSpan(
                      text: 'Size: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: shirtList[2].shirtColor,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        sportDressPiece++;
                        sportDressAmount =
                            shirtList[2].shirtPrice * sportDressPiece;
                        calTotalAmount();
                      });
                    },
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.add, size: 36),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$sportDressPiece',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        sportDressPiece <= 0 ? null : sportDressPiece--;
                        sportDressAmount =
                            shirtList[2].shirtPrice * sportDressPiece;
                        calTotalAmount();
                      });
                    },
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.remove, size: 36),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.more_vert),
              Text(
                "$sportDressAmount\$",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container tShirt() {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(shirtList[1].imagePath),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shirtList[1].shirtType,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Color: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: shirtList[1].shirtColor,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const TextSpan(text: '   '),
                    const TextSpan(
                      text: 'Size: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: shirtList[1].shirtColor,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tShirtPiece++;
                        tShirtAmount = shirtList[1].shirtPrice * tShirtPiece;
                        calTotalAmount();
                      });
                    },
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.add, size: 36),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$tShirtPiece',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tShirtPiece <= 0 ? null : tShirtPiece--;
                        tShirtAmount = shirtList[1].shirtPrice * tShirtPiece;
                        calTotalAmount();
                      });
                    },
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.remove, size: 36),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.more_vert),
              Text(
                "$tShirtAmount\$",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container pullOverShirt() {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(shirtList[0].imagePath),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shirtList[0].shirtType,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Color: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: shirtList[0].shirtColor,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const TextSpan(text: '   '),
                    const TextSpan(
                      text: 'Size: ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: shirtList[0].shirtColor,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        pullOverPiece++;
                        pullOverAmount =
                            shirtList[0].shirtPrice * pullOverPiece;
                        calTotalAmount();
                      });
                    },
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.add, size: 36),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$pullOverPiece',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        pullOverPiece <= 0 ? null : pullOverPiece--;
                        pullOverAmount =
                            shirtList[0].shirtPrice * pullOverPiece;
                        calTotalAmount();
                      });
                    },
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.remove, size: 36),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.more_vert),
              Text(
                "$pullOverAmount\$",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
