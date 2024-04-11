import 'package:ct484_project/ui/cart/cart.dart';
import 'package:ct484_project/ui/favorite/favorite.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here, you would typically fetch the list of cart items from somewhere
    // For demonstration purposes, let's assume you have a list of items

    List<FavoriteItemData> FavoriteItems = [
      FavoriteItemData(
        id: 1,
        imagePath:
            'https://th.bing.com/th/id/R.8c8880f40845652dac35e40bb934e8e1?rik=elW37a26DQ6znw&pid=ImgRaw&r=0',
        productName: 'Product 1',
        pricePerProduct: 100,
      ),
      
      FavoriteItemData(
        id: 2,
        imagePath:
            'https://1.bp.blogspot.com/-N8jrhU8fmkQ/WdSn_BbvZXI/AAAAAAAADHQ/xANL-2oihggBWJ1gbN9GV_XeOSxUatXswCLcBGAs/s1600/tai-nghe-bluetooth-blue-1.jpg',
        productName: 'Product 2',
        pricePerProduct: 50,
      ),

      FavoriteItemData(
        id: 2,
        imagePath:
            'https://1.bp.blogspot.com/-N8jrhU8fmkQ/WdSn_BbvZXI/AAAAAAAADHQ/xANL-2oihggBWJ1gbN9GV_XeOSxUatXswCLcBGAs/s1600/tai-nghe-bluetooth-blue-1.jpg',
        productName: 'Product 2',
        pricePerProduct: 50,
      ),
      FavoriteItemData(
        id: 2,
        imagePath:
            'https://1.bp.blogspot.com/-N8jrhU8fmkQ/WdSn_BbvZXI/AAAAAAAADHQ/xANL-2oihggBWJ1gbN9GV_XeOSxUatXswCLcBGAs/s1600/tai-nghe-bluetooth-blue-1.jpg',
        productName: 'Product 2',
        pricePerProduct: 50,
      ),
      // Add more items as needed
    ];

    return ListView.builder(
      itemCount: FavoriteItems.length,
      itemBuilder: (context, index) {
        final item = FavoriteItems[index];
        return FavoriteItem(
          id: item.id,
          imagePath: item.imagePath,
          productName: item.productName,
          pricePerProduct: item.pricePerProduct,
        );
      },
    );
  }
}




class FavoriteItemData {
  final int id;
  final String imagePath;
  final String productName;
  final int pricePerProduct;

  const FavoriteItemData({
    required this.id,
    required this.imagePath,
    required this.productName,
    required this.pricePerProduct,
  });
}
