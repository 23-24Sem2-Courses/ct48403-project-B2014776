import 'package:flutter/material.dart';

import '../../model/product.dart';
import 'editProduct.dart';

class AdminCard extends StatefulWidget {
  final Product product;
  final VoidCallback onPressed;
  final Function(String) onDeleteSuccess;
  const AdminCard({
    Key? key,
    required this.product,
    required this.onPressed, required this.onDeleteSuccess,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<AdminCard> {
  bool isClear = false;
  bool isEdit = false;

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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(widget.product.imageUrl.toString()),
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
                        Icons.clear, // Thay đổi icon yêu thích thành icon "clear"
                        color: isClear ? Colors.black : Colors.black,
                        size: 24.0,
                      ),
                      onPressed: () {

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return
                              AlertDialog(
                              title: Text("Are you sure"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isClear = !isClear;
                                    });
                                    Navigator.of(context).pop();
                                    try{
                                    Product.deleteProductById(widget.product.id.toString());
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Delete success'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),

                                    );
                                    widget.onDeleteSuccess(widget.product.id.toString());
                                    }
                                    catch (e){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Delete failed'),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }

                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
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
                        widget.product.productName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.price.toString()+" vnđ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.brush_outlined,
                              color: isEdit ? Colors.black : Colors.black,
                              size: 24,
                            ),
                            onPressed: () {
                              // Chuyển hướng sang một trang khác khi nhấn vào icon "edit"
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>   EditProduct(product: widget.product)),
                              );
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
    );
  }
}


