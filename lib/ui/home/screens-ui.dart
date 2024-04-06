import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:ct484_project/ui/home/MySearchBar.dart';
import 'package:ct484_project/ui/home/Mytags.dart';
import 'package:ct484_project/ui/home/banner.dart';
import 'package:ct484_project/ui/home/product/card.dart';
import 'package:ct484_project/ui/home/product/productList.dart';
import 'package:flutter/material.dart';

class Screens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), // Đặt chiều cao cho AppBar
        child: MyAppBar(),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.0), // Lề trái và lề phải là 16.0
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySearchBar(),
            MyBanner(),
            MyTag(),
            Expanded(child: ProductList())
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/header-images/homelogo.png',
              width:
                  24, // Điều chỉnh kích thước biểu tượng theo nhu cầu của bạn
              height: 24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/header-images/Fvrlogo.png',
              width:
                  24, // Điều chỉnh kích thước biểu tượng theo nhu cầu của bạn
              height: 24,
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/header-images/shopinglogo.png',
                width:
                    24, // Điều chỉnh kích thước biểu tượng theo nhu cầu của bạn
                height: 24,
              ),
              label: "Shopping"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/header-images/editicon.png',
                width:
                    24, // Điều chỉnh kích thước biểu tượng theo nhu cầu của bạn
                height: 24,
              ), 
              label: "Edit"),
        ],
      ),
    );
  }
}

class Mycard extends StatelessWidget {
  const Mycard({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                'https://media.wired.com/photos/64daad6b4a854832b16fd3bc/master/w_1920,c_limit/How-to-Choose-a-Laptop-August-2023-Gear.jpg',
            price: 499.99, // Replace with actual product price
            onPressed: () {
              // Add to cart functionality
            },
          );
        },
      ),
    );
  }
}
