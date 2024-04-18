import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ct484_project/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'cart.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  late Future<Cart> _futureCart;

  @override
  void initState() {
    super.initState();

    _futureCart = Cart.getUserCart();

  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cart>(
      future: _futureCart,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('No items in the cart'),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text('No items in the cart'),
          );
        } else {
          final cart = snapshot.data!;
          return ListView.builder(
            itemCount: cart.products.length,
            itemBuilder: (context, index) {
              final item = cart.products[index];
              return CartItemUI(
                id: item.product.id.toString(),
                imagePath: item.product.imageUrl.toString(),
                productName: item.product.productName,
                quantity: item.quantity,
                pricePerProduct: (item.quantity*item.product.price).toInt(),
                onDeleteSuccess: (productId) {
                  setState(() {
                    // Remove the deleted product from the list
                    cart.products.removeAt(index);
                  });
                },
              );
            },
          );
        }
      },
    );
  }
}
