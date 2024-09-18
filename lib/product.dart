import 'package:flutter/material.dart';

import 'item.dart';

class Product extends StatelessWidget {
  final Item item;

  const Product({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Code: ${item.code}"),
          Text("Price: \$${item.price}"),
          Text("Quantity: ${item.quantity}"),
          Text("Total Price: \$${item.totalPrice}"),
          const Divider(thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: item.onEdit,
                icon: const Icon(Icons.edit),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                ),
                label: const Text("Edit"),
              ),
              TextButton.icon(
                onPressed: item.onDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
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
