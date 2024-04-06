import 'package:ct484_project/ui/account/loginScreen.dart';
import 'package:ct484_project/ui/product/product-screen.dart';
import 'package:ct484_project/ui/home/screens-ui.dart';
import 'package:ct484_project/ui/splash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'PT DEVICE SHOP',
      // home: Screens(),
      home: MyProduct(), // Chỉ định HomeUI là trang chính của ứng dụng
    );
  }
}
