import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.imagePath,
    required this.onPressed,
  }) : super(key: key);

  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 200, // Điều chỉnh chiều cao của thẻ
        margin: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 16), // Điều chỉnh khoảng cách giữa các thẻ
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Điều chỉnh bo góc của thẻ
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover, // Chỉnh sửa hình ảnh để lấp đầy toàn bộ phần nền
          ),
        ),
      ),
    );
  }
}

class HomeCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        child:
        
        
        
         ListView(
          children: [
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
          ],
        ),
      );
  }
}
