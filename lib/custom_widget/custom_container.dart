import 'package:flutter/material.dart';

class ShirtWidget extends StatelessWidget {
  final String imagePath;
  final String shirtType;
  final String shirtColor;
  final String shirtSize;
  final int shirtPrice;
  final int shirtPiece;
  final int shirtPriceTotal;
  final void Function() incrementPiece;
  final void Function() decrementPiece;

  const ShirtWidget({
    super.key,
    required this.imagePath,
    required this.shirtType,
    required this.shirtColor,
    required this.shirtSize,
    required this.shirtPrice,
    required this.incrementPiece,
    required this.decrementPiece,
    required this.shirtPiece,
    required this.shirtPriceTotal,
  });

  @override
  Widget build(BuildContext context) {
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
          Image.asset(imagePath),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                shirtType,
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
                      text: shirtColor,
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
                      text: shirtColor,
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
                    onTap: incrementPiece,
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.add, size: 36),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$shirtPiece',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: decrementPiece,
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
                "$shirtPriceTotal\$",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
