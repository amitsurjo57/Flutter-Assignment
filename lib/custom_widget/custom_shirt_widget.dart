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
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.fitHeight,
                height: 128,
                width: 100,
              ),
              const SizedBox(width: 24),
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
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: incrementPiece,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.add, size: 36),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '$shirtPiece',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: decrementPiece,
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.remove, size: 36),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 44),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(Icons.more_vert),
                  const SizedBox(height: 80),
                  Text(
                    "$shirtPriceTotal\$",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
