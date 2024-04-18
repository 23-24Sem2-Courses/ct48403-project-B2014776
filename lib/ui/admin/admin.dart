import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../account/component.dart';
import '../account/loginScreen.dart';
import 'addproduct.dart';
import 'adminListcard.dart';

class AdminList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Image.asset(
                'assets/header-images/logo.jpg',
                width: 120,
                height: 44,
                fit: BoxFit.contain,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Image.asset(
                'assets/header-images/logout.png',
                width: 30,
                height: 30,
              ),
              onPressed: () {
                // Logout action
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
        toolbarHeight: 44.0,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // Handle refresh action here
          // You can reload data or perform any other necessary operations
          return Future.delayed(Duration(seconds: 1), () {
            // Return a Future to indicate when refreshing is complete
            // Trigger the refresh of AdminListCard
            _adminListCardKey.currentState?.reloadData();
          });
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: AdminListCard(
                  key: _adminListCardKey, // Assign a GlobalKey to AdminListCard
                ),
              ),
              CustomElevatedButton(
                text: "Add Product",
                onPressed: () {
                  // Navigate to AddProduct screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddProduct()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Define a GlobalKey for AdminListCard
final GlobalKey<AdminListCardState> _adminListCardKey = GlobalKey();