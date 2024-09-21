import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greeting_app/snack_bar.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new item"),
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
                      onPressed: _onAddItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        fixedSize: const Size.fromWidth(double.maxFinite),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text("Add Item"),
                    ),
            ],
          ),
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
              labelText: "Enter product name",
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
              labelText: "Enter product code",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              } else if (int.tryParse(_codeController.text).runtimeType !=
                  int) {
                return 'Code should be a number';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter product price",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              } else if (int.tryParse(_priceController.text).runtimeType !=
                  int) {
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
              labelText: "Enter product quantity",
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
              labelText: "Enter total price",
              border: OutlineInputBorder(),
            ),
            validator: (String? valid) {
              if (valid == null || valid.isEmpty) {
                return 'Fill up all text field';
              } else if (int.tryParse(_totalPriceController.text).runtimeType !=
                  int) {
                return 'Total price should be a number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _onAddItem() {
    if (_globalKey.currentState!.validate()) {
      addItem();
    }
  }

  Future<void> addItem() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/CreateProduct');
    Map<String, dynamic> addEncodeItem = {
      "ProductName": _nameController.text,
      "ProductCode": _codeController.text,
      "Img": _nameController.text,
      "UnitPrice": _priceController.text,
      "Qty": _quantityController.text,
      "TotalPrice": _totalPriceController.text,
    };
    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(addEncodeItem),
    );
    if (response.statusCode == 200) {
      _clearTextField();
      showSnackBar();
    }
    _inProgress = false;
    setState(() {});
  }

  void showSnackBar() {
    MySnackBar.mySnackBar(context, message: 'Item Added',icon: Icons.add);
  }

  void _clearTextField() {
    _nameController.clear();
    _codeController.clear();
    _priceController.clear();
    _quantityController.clear();
    _totalPriceController.clear();
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
