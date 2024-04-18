import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';
import 'admincard.dart';

class AdminListCard extends StatefulWidget {
  // Define a key for the stateful widget
  final Key? key;

  const AdminListCard({this.key}) : super(key: key);

  @override
  AdminListCardState createState() => AdminListCardState();
}

class AdminListCardState extends State<AdminListCard> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = Product.fetchAllProducts();
  }

  // Method to reload data
  void reloadData() {
    setState(() {
      _futureProducts = Product.fetchAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = products[index];
                  return AdminCard(
                    product: product,
                    onPressed: () {
                      // Add to cart functionality
                    },
                    onDeleteSuccess: (productId) {
                      setState(() {
                        // Remove the deleted product from the list
                        products.removeWhere((product) => product.id == productId);
                      });
                    },
                  );
                },
              ),
            );
          }
        }

    );
  }
}