import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:greeting_app/product.dart';
import 'package:greeting_app/snack_bar.dart';
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
      extendBody: true,
      appBar: AppBar(
        title: const Text(
          "Product List",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value) async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewProductScreen(),
            ),
          );
          getItem();
        },
        items: const [
          Icon(
            Icons.add,
            color: Colors.white,
            size: 36,
          ),
        ],
        height: 60,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: getItem,
                  child: const Icon(
                    Icons.refresh,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.arrow_upward,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.arrow_downward,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ],
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
    MySnackBar.mySnackBar(context, message: 'Item Deleted',icon: Icons.delete);
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
