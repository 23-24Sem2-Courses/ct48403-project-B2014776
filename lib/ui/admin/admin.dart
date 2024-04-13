import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/account/loginScreen.dart';
import 'package:ct484_project/ui/admin/adminListcard.dart';
import 'package:ct484_project/ui/bottombar.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:ct484_project/ui/home/product/productList.dart';
import 'package:flutter/material.dart';

class AdminList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing:
            0, // Loại bỏ khoảng cách giữa tiêu đề và các phần tử bên cạnh
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Image.asset(
                'assets/header-images/logo.jpg',
                width: 120,
                height: 44, // Đặt chiều cao của ảnh là 44
                fit: BoxFit.contain, // Đảm bảo ảnh vừa với chiều cao của AppBar
              ),
            ),
            Spacer(), // Tạo khoảng trống linh hoạt giữa các phần tử
            IconButton(
              icon: Image.asset(
                'assets/header-images/logout.png',
                width: 30, // Đặt chiều rộng của icon
                height: 30, // Đặt chiều cao của icon
              ),
              onPressed: () {
                // Chuyển hướng sang một trang khác khi nhấn vào icon "edit"
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );

                // Xử lý sự kiện khi nhấn vào icon link
              },
            ),
          ],
        ),
        toolbarHeight: 44.0, // Đặt chiều cao cho toolbar của AppBar
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: AdminListCard(), // Sử dụng CartList ở đây
            ),
            CustomElevatedButton(text: "Add Product"),
          ],
        ),
      ),
    );
  }
}
