import 'package:ct484_project/ui/product/product-screen.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';
import 'card.dart';




class ProductList extends StatefulWidget
{
  final String category;

  const ProductList({super.key, required this.category});
  @override
  _ProductListState createState() => _ProductListState(category);
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> _futureProducts;
  final String category;

  _ProductListState(this.category);
  @override
  void initState() {
    super.initState();
    if(category=="laptop"){
      _futureProducts = Product.fetchLaptopProducts();
    }
    else if(category=="smart_phone"){
      _futureProducts = Product.fetchSmartPhoneProducts();

    }
    else{
      _futureProducts = Product.fetchAccessoriesProducts();
    }


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('No products available ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No products available'),
          );
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final product = snapshot.data![index];
              return ProductCard(
                id: product.id.toString(),
                productName: product.productName,
                productDescription: product.productDescription,
                imageUrl: product.imageUrl.toString(),
                price: product.price,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  ProductDetail( productId:product.id.toString())),
                  );

                },
              );
            },
          );
        }
      },
    );
  }
}
