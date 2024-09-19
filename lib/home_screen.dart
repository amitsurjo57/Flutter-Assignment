import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greeting_app/product.dart';
import 'package:greeting_app/update_product_screen.dart';
import 'package:http/http.dart';

import 'add_new_product_screen.dart';
import 'item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> itemList = [];
  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    getItem();
  }

  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
              child: const Column(
                children: [
                  Icon(Icons.arrow_upward),
                  Text('Top'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                );
              },
              child: const Column(
                children: [
                  Icon(Icons.arrow_downward),
                  Text('Bottom'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: FloatingActionButton(
              onPressed: getItem,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(
                Icons.refresh_rounded,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: addItem,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.add, size: 32, color: Colors.black),
          ),
        ],
      ),
      body: _inProgress
          ? const Center(child: CircularProgressIndicator())
          : itemList.isEmpty
              ? const Center(
                  child: Text(
                    'List is empty.',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return Product(
                      item: Item(
                        name: itemList[index].name,
                        id: itemList[index].id,
                        code: itemList[index].code,
                        price: itemList[index].price,
                        quantity: itemList[index].quantity,
                        totalPrice: itemList[index].totalPrice,
                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProductScreen(
                                item: itemList[index],
                              ),
                            ),
                          );
                          getItem();
                        },
                        onDelete: () => deleteItem(itemList[index].id),
                      ),
                    );
                  },
                ),
    );
  }

  Future<void> addItem() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewProductScreen(),
      ),
    );
    _inProgress = true;
    setState(() {});
    getItem();
  }

  Future<void> deleteItem(String id) async {
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/$id');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      snackBar();
    }
    getItem();
  }

  void snackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item Deleted'),
      ),
    );
  }

  Future<void> getItem() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      itemList.clear();
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      for (var item in jsonResponse['data']) {
        Item newItem = Item(
          name: item['ProductName'] ?? ' ',
          id: item['_id'] ?? ' ',
          code: item['ProductCode'] ?? ' ',
          price: item['UnitPrice'] ?? ' ',
          quantity: item['Qty'] ?? ' ',
          totalPrice: item['TotalPrice'] ?? ' ',
        );
        itemList.add(newItem);
      }
    }
    _inProgress = false;
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
