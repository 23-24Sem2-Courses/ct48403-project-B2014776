import 'package:ct484_project/ui/bottombar.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:ct484_project/ui/home/MySearchBar.dart';
import 'package:ct484_project/ui/home/banner.dart';
import 'package:ct484_project/ui/home/homecart.dart';
import 'package:ct484_project/ui/home/product/card.dart';
import 'package:ct484_project/ui/home/product/productList.dart';
import 'package:ct484_project/ui/product/ListProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';



class Screens extends StatefulWidget {
  @override
  _ScreensState createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  List<Product> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: MyAppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySearchBar(
                onSearchResultsReceived: (results) {
                  setState(() {
                    searchResults = results;
                  });
                },
              ),
              SizedBox(height: 10),

              SizedBox(height: 10),
              MyBanner(),
              SizedBox(height: 10),
              HomeCard(
                imagePath: 'assets/header-images/nenphone.png',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListProduct(category: "smart_phone")),
                  );
                },
              ),
              HomeCard(
                imagePath: 'assets/header-images/nenlap.png',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListProduct(category: "laptop")),
                  );
                },
              ),
              HomeCard(
                imagePath: 'assets/header-images/nendevices.png',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListProduct(category: "accessories")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
