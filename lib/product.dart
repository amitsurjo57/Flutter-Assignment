import 'package:flutter/material.dart';

import 'item.dart';

class Product extends StatelessWidget {
  final Item item;

  const Product({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: ListTile(
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Code: ${item.code}"),
                  Text("Price: \$${item.price}"),
                  Text("Quantity: ${item.quantity}"),
                  Text("Total Price: \$${item.totalPrice}"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: item.onEdit,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.lightBlueAccent,
                ),
                style: ElevatedButton.styleFrom(elevation: 4),
                label: const Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: item.onDelete,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ),
                style: ElevatedButton.styleFrom(elevation: 4),
                label: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
