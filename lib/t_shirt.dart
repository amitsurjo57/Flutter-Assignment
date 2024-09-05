import 'package:flutter/material.dart';

class TShirt extends StatefulWidget {
  final String imagePath;
  final String shirtType;
  final String shirtColor;
  final String shirtSize;
  final int shirtPrice;

  const TShirt({
    super.key,
    required this.imagePath,
    required this.shirtType,
    required this.shirtColor,
    required this.shirtSize,
    required this.shirtPrice,
  });

  @override
  State<TShirt> createState() => _TShirtState();
}

class _TShirtState extends State<TShirt> {
  int shirtPiece = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(widget.imagePath),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.shirtType,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
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
                      text: widget.shirtColor,
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
                      text: widget.shirtSize,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  InkWell(
                    onTap: () => setState(() {
                      shirtPiece++;
                    }),
                    child: const Card(
                      elevation: 4,
                      child: Icon(Icons.add, size: 36),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$shirtPiece',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () => setState(
                      () {
                        shirtPiece <= 0 ? null : shirtPiece--;

                      },
                    ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.more_vert),
              Text(
                "${widget.shirtPrice * shirtPiece}\$",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
