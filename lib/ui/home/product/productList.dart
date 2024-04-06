import 'package:ct484_project/ui/home/product/card.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
   

    return  Padding(
        padding: const EdgeInsets.all(0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,

          ),
          itemCount: 100, // Change this according to your data length
          itemBuilder: (BuildContext context, int index) {
            return ProductCard(
              productName: 'Product $index', // Replace with actual product data
              productDescription: 'Description for Product $index',
              imageUrl:
              'https://www.bhphotovideo.com/images/images2500x2500/hp_2gw59ua_aba_i7_7500u_8gb_1tb_windows_1362830.jpg',
              price: 499.99, // Replace with actual product price
              onPressed: () {
                // Add to cart functionality
              },
            );
          },
        ),
      );
}}