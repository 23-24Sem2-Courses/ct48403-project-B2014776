import 'package:ct484_project/model/product.dart';
import 'package:ct484_project/ui/bottombar.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:ct484_project/ui/home/product/productList.dart';
import 'package:flutter/material.dart';

import '../home/MySearchBar.dart';



class ListProduct extends StatelessWidget {
  final String category;

  const ListProduct({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), // Đặt chiều cao cho AppBar
        child: MyAppBar(),
      ),
      body: Container(
        child: Column(
          children: [

            Expanded(child: ProductList(category: category,)), // Sử dụng CartList ở đây
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}




class SearchProduct extends StatelessWidget {
  final List<Product> searchResult;
  final String searchText;

  const SearchProduct({super.key, required this.searchResult, required this.searchText});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), // Đặt chiều cao cho AppBar
        child: MyAppBar(),
      ),
      body: Container(
        child: Column(
          children: [
            MySearchBar(initialSearchText: searchText,),

            Expanded(child: SearchResultsWidget(searchResults: searchResult,)), // Sử dụng CartList ở đây
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

