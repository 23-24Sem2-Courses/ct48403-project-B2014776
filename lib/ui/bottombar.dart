import 'package:ct484_project/ui/cart/cart.dart';
import 'package:ct484_project/ui/favorite/favorite.dart';
import 'package:ct484_project/ui/home/screens-ui.dart';
import 'package:ct484_project/ui/me/me.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Image.asset(
              'assets/header-images/homelogo.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Xử lý khi nhấn vào biểu tượng Home
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Screens()),
              );
            },
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Image.asset(
              'assets/header-images/Fvrlogo.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Xử lý khi nhấn vào biểu tượng Favorites
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyFavorite()),
              );
            },
          ),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Image.asset(
              'assets/header-images/shopinglogo.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Xử lý khi nhấn vào biểu tượng Cart
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCart()),
              );
            },
          ),
          label: "Cart",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            icon: Image.asset(
              'assets/header-images/editicon.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // Xử lý khi nhấn vào biểu tượng Me
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAccout()),
              );
            },
          ),
          label: "Me",
        ),
      ],
    );
  }
}
