import 'package:flutter/material.dart';
import 'package:ct484_project/model/product.dart';

import '../../model/wishlist.dart';
import 'favorite.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  late List<Product> favoriteItems;

  @override
  void initState() {
    super.initState();
    loadFavoriteItems();
  }

  Future<void> loadFavoriteItems() async {
    try {
      final List<Product> fetchedItems = await Wishlist.getUserWishlist();
      setState(() {
        favoriteItems = fetchedItems;
      });
    } catch (e) {
      // Handle error
      print('Failed to fetch favorite items: $e');
      throw Exception('Failed to fetch favorite items: $e');
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    try {
      await Wishlist.removeFromWishlist(productId);
      setState(() {
        favoriteItems.removeWhere((item) => item.id == productId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Removed from favorites successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to remove from favorites'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return favoriteItems.isEmpty
        ? const Center(
      child: Text("No favorite items available"),
    )
        : ListView.builder(
      itemCount: favoriteItems.length,
      itemBuilder: (context, index) {
        final item = favoriteItems[index];
        return FavoriteItem(
          id: item.id.toString(),
          imagePath: item.imageUrl.toString(),
          productName: item.productName,
          pricePerProduct: item.price.toInt(),
          onRemove: () => removeFromFavorites(item.id.toString()),
        );
      },
    );
  }
}
