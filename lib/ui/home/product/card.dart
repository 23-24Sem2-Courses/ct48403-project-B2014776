import 'package:ct484_project/model/wishlist.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String id;
  final String productName;
  final String productDescription;
  final String imageUrl;
  final double price;
  final VoidCallback onPressed;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.productDescription,
    required this.imageUrl,
    required this.price,
    required this.onPressed, required this.id,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 217,
        width: 163.0,
        child: Card(
            elevation: 4,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite
                                    ? Colors.black
                                    : Color.fromARGB(255, 143, 140, 140),
                                size: 24.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;

                                });
                                try{
                                  Wishlist.addToWishlist(widget.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Add to favorite success'),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                                catch(e)
                                {
                                  print("error $e");
                                  const SnackBar(
                                    content: Text('Add to favorite failed'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                  );
                                }


                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0.1),
                              Color.fromRGBO(0, 0, 0, 0),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.productName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.price.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: isInCart
                                          ? Colors.black
                                          : Color.fromARGB(255, 143, 140, 140),
                                      size: 24.0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isInCart = !isInCart;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
