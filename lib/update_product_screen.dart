import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'item.dart';

class UpdateProductScreen extends StatefulWidget {
  final Item item;

  const UpdateProductScreen({
    super.key,
    required this.item,
  });

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _inProgress = false;

  @override
  void initState() {
    _nameController.text = widget.item.name;
    _codeController.text = widget.item.code;
    _priceController.text = widget.item.price;
    _quantityController.text = widget.item.quantity;
    _totalPriceController.text = widget.item.totalPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Item"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              textFieldForm(),
              const SizedBox(height: 48),
              _inProgress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_globalKey.currentState!.validate()) {
                          _onUpdateItem(widget.item.id);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        fixedSize: const Size.fromWidth(double.maxFinite),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("DONE"),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onUpdateItem(String id) async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/UpdateProduct/$id');
    Map<String, dynamic> responseBody = {
      "ProductName": _nameController.text,
      "ProductCode": _codeController.text,
      "Img": _nameController.text,
      "UnitPrice": _priceController.text,
      "Qty": _quantityController.text,
      "TotalPrice": _totalPriceController.text,
    };
    Response response = await post(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(responseBody),
    );

    if (response.statusCode == 200) {
      snackBar();
    }
    _inProgress = false;
    setState(() {});
  }

  void snackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item Updated',
        ),
      ),
    );
  }

  Form textFieldForm() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Update product name",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Update product code",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              } else if (int.tryParse(_codeController.text).runtimeType !=
                  int) {
                return 'Code should be a big number';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Update product price",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              } else if (double.tryParse(_priceController.text).runtimeType !=
                  double) {
                return 'Price should be a number';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Update product quantity",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              } else if (int.tryParse(_quantityController.text).runtimeType !=
                  int) {
                return 'Quantity should be a number';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _totalPriceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Update total price",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              } else if (double.tryParse(_totalPriceController.text)
                      .runtimeType !=
                  double) {
                return 'Total price should be a number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }
}
