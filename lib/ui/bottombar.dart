import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart/cart.dart';
import 'favorite/favorite.dart';
import 'home/screens-ui.dart';
import 'me/me.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0; // Biến để theo dõi chỉ số của biểu tượng được chọn

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      selectedItemColor: Colors.red, // Thay đổi màu sắc của các biểu tượng đã chọn
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        // Xử lý khi nhấn vào biểu tượng tương ứng
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Screens()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyFavorite()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyCart()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAccout()),
            );
            break;
          default:
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/header-images/homelogo.png',
            width: 24,
            height: 24,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/header-images/Fvrlogo.png',
            width: 24,
            height: 24,
          ),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/header-images/shopinglogo.png',
            width: 24,
            height: 24,
          ),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/header-images/editicon.png',
            width: 24,
            height: 24,
          ),
          label: "Me",
        ),
      ],
    );
  }
}
