import 'package:ct484_project/ui/cart/cart.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here, you would typically fetch the list of cart items from somewhere
    // For demonstration purposes, let's assume you have a list of items

    List<CartItemData> cartItems = [
      CartItemData(
        id: 1,
        imagePath:
            'https://th.bing.com/th/id/R.8c8880f40845652dac35e40bb934e8e1?rik=elW37a26DQ6znw&pid=ImgRaw&r=0',
        productName: 'Product 1',
        quantity: 2,
        pricePerProduct: 100,
      ),
      CartItemData(
        id: 2,
        imagePath:
            'https://1.bp.blogspot.com/-N8jrhU8fmkQ/WdSn_BbvZXI/AAAAAAAADHQ/xANL-2oihggBWJ1gbN9GV_XeOSxUatXswCLcBGAs/s1600/tai-nghe-bluetooth-blue-1.jpg',
        productName: 'Product 2',
        quantity: 1,
        pricePerProduct: 50,
      ),

      CartItemData(
        id: 2,
        imagePath:
            'https://1.bp.blogspot.com/-N8jrhU8fmkQ/WdSn_BbvZXI/AAAAAAAADHQ/xANL-2oihggBWJ1gbN9GV_XeOSxUatXswCLcBGAs/s1600/tai-nghe-bluetooth-blue-1.jpg',
        productName: 'Product 2',
        quantity: 1,
        pricePerProduct: 50,
      ),
      CartItemData(
        id: 2,
        imagePath:
            'https://1.bp.blogspot.com/-N8jrhU8fmkQ/WdSn_BbvZXI/AAAAAAAADHQ/xANL-2oihggBWJ1gbN9GV_XeOSxUatXswCLcBGAs/s1600/tai-nghe-bluetooth-blue-1.jpg',
        productName: 'Product 2',
        quantity: 1,
        pricePerProduct: 50,
      ),
      // Add more items as needed
    ];

    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return CartItem(
          id: item.id,
          imagePath: item.imagePath,
          productName: item.productName,
          quantity: item.quantity,
          pricePerProduct: item.pricePerProduct,
        );
      },
    );
  }
}




class CartItemData {
  final int id;
  final String imagePath;
  final String productName;
  final int quantity;
  final int pricePerProduct;

  const CartItemData({
    required this.id,
    required this.imagePath,
    required this.productName,
    required this.quantity,
    required this.pricePerProduct,
  });
}
