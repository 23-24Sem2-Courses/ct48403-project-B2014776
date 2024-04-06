import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
              child: Image.asset(
                'assets/header-images/logo.jpg',
                width: 120,
                height: 44, // Đặt chiều cao của ảnh là 44
                fit: BoxFit.contain, // Đảm bảo ảnh vừa với chiều cao của AppBar
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      toolbarHeight: 44.0, // Đặt chiều cao cho toolbar của AppBar
    );
  }
}
