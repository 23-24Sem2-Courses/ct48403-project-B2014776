import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 20,
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
