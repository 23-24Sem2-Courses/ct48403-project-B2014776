import 'package:ct484_project/ui/account/SignUpScreen.dart';
import 'package:ct484_project/ui/account/loginScreen.dart';
import 'package:ct484_project/ui/admin/addproduct.dart';
// import 'package:ct484_project/ui/admin/addProduct.dart';
import 'package:ct484_project/ui/admin/admin.dart';
import 'package:ct484_project/ui/admin/editProduct.dart';
import 'package:ct484_project/ui/cart/cart.dart';
import 'package:ct484_project/ui/favorite/favorite.dart';
import 'package:ct484_project/ui/home/homecart.dart';
import 'package:ct484_project/ui/me/me.dart';
import 'package:ct484_project/ui/product/ListProduct.dart';
import 'package:ct484_project/ui/product/product-screen.dart';
import 'package:ct484_project/ui/home/screens-ui.dart';
import 'package:ct484_project/ui/splash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  // Run đi
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'PT DEVICE SHOP',
      // home: Screens(),
      //home: HomeCardPage(),
      // home: MyProduct(), // Chỉ định HomeUI là trang chính của ứng dụng
      //home: MyCart(),
      // home: MyFavorite(),
      // home: ListProduct(),
      // home: MyAccout(),
      //   home:  SplashScreen(),
        // home:AdminList(),
        //  home: EditProduct(),
        // home: AddProduct(),
        // home: SignUpPage(),
      
    );
  }
}
