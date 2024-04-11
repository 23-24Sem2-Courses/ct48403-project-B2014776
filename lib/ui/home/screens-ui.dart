import 'package:ct484_project/ui/bottombar.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:ct484_project/ui/home/MySearchBar.dart';
import 'package:ct484_project/ui/home/banner.dart';
import 'package:ct484_project/ui/home/homecart.dart';
import 'package:ct484_project/ui/home/product/card.dart';
import 'package:flutter/material.dart';

class Screens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), // Đặt chiều cao cho AppBar
        child: MyAppBar(),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 0.0), // Lề trái và lề phải là 16.0
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySearchBar(),

              MyBanner(),

              HomeCard(
                imagePath:
                    'assets/header-images/nenphone.png', // Đường dẫn đến hình ảnh cho thẻ 1
                onPressed: () {
                  // Xử lý khi thẻ 1 được nhấn
                },
              ),
              HomeCard(
                imagePath:
                    'assets/header-images/nenlap.png', // Đường dẫn đến hình ảnh cho thẻ 2
                onPressed: () {
                  // Xử lý khi thẻ 2 được nhấn
                },
              ),
              HomeCard(
                imagePath:
                    'assets/header-images/nendevices.png', // Đường dẫn đến hình ảnh cho thẻ 2
                onPressed: () {
                  // Xử lý khi thẻ 2 được nhấn
                },
              ), // Thêm các thẻ khác tương tự ở đây

              // HomeCardPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
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
