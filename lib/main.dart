// import 'package:ct484_project/ui/admin/addProduct.dart';
import 'package:ct484_project/ui/admin/admin.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PT DEVICE SHOP',
      home: SplashScreen(),
    );
  }
}
