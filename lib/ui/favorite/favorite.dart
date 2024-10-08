import 'package:ct484_project/model/wishlist.dart';
import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/bottombar.dart';
import 'package:ct484_project/ui/favorite/FavoriteList.dart';
import 'package:flutter/material.dart';
import 'package:ct484_project/ui/cart/cart.dart';

class MyFavorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 44.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Favorites',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: FavoriteList()), // Sử dụng CartList ở đây
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String id;
  final String imagePath;
  final String productName;
  final int pricePerProduct;
  final VoidCallback onRemove; // Define the onRemove callback
  const FavoriteItem({
    Key? key,
    required this.id,
    required this.imagePath,
    required this.productName,
    required this.pricePerProduct, required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(27, 25, 86, 0.4),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
          color: Color.fromRGBO(250, 250, 251, 1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 327,
          height: 169,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 110,
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, top: 20, right: 6), // Đặt khoảng cách left
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Đặt alignment của column thành start
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              productName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            height: 40,
                            child:
                            FavoriteIcon(product_id: id,), // Sử dụng FavoriteIcon thay cho Icon(Icons.favorite)
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10), // Đặt khoảng cách top
                        child: Text(
                          '\$ $pricePerProduct', // Hiển thị giá tiền sản phẩm
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatefulWidget {
  final String product_id;

  const FavoriteIcon({super.key, required this.product_id});
  @override
  _FavoriteIconState createState() => _FavoriteIconState(product_id: product_id);
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFavorite = false;
  final String product_id;

  _FavoriteIconState({required this.product_id});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.black : null,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm'),
              content: Text('Are you sure you want to remove this item from favorites?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await Wishlist.removeFromWishlist(product_id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Remove from favorites success'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Remove from favorites failed'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
