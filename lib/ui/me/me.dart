import 'dart:io';

import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/account/loginScreen.dart';
import 'package:ct484_project/ui/bottombar.dart';
import 'package:ct484_project/ui/favorite/FavoriteList.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:ct484_project/ui/cart/cart.dart';

import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/bottombar.dart';
import 'package:ct484_project/ui/favorite/FavoriteList.dart';
import 'package:flutter/material.dart';
import 'package:ct484_project/ui/cart/cart.dart';

class MyAccout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), // Đặt chiều cao cho AppBar
        child: MyAppBar(),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Phần 1: Icon được lưu sẵn trong máy
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                border: Border.all(
                  color: Colors.black, // Màu viền đen
                  width: 1.0, // Độ dày của viền
                ),
              ),
              padding: EdgeInsets.all(0.0), // Padding cho container
              child: SizedBox(
                height: 300,
                // Đặt độ cao của phần icon
                width: double.infinity, // Mở rộng toàn bộ chiều rộng của cột
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/b7/72/f1/b772f11bd2a8ff5b067ae33b556f1a00.jpg'),
                      fit: BoxFit
                          .cover, // Đặt giá trị của fit thành BoxFit.cover
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30), // Khoảng cách giữa hai phần
            // Phần 2: Row chứa icon và từ 'Log out'
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Màu viền đen
                  width: 1.0, // Độ dày của viền
                ),
                borderRadius: BorderRadius.circular(10.0), // Bo góc 10
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10.0, // Padding lề dọc
                horizontal: 20.0, // Padding lề ngang
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Căn giữa phần từ và icon
                children: [
                  // Từ 'Log out'
                  Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 20.0, // Đặt kích thước cho văn bản
                      fontWeight: FontWeight.bold, // Đặt độ đậm cho văn bản
                    ),
                  ),
                  // Icon được lưu sẵn trong máy
                  GestureDetector(
                    onTap: () {
                      // Xử lý sự kiện khi nhấn vào icon 2
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Image.asset(
                      'assets/header-images/logout.png', // Đường dẫn tới ảnh icon 2
                      width: 45, // Đặt chiều rộng của ảnh
                      height: 45, // Đặt chiều cao của ảnh
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
