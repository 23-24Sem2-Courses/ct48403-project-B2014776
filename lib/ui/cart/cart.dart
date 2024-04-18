import 'package:ct484_project/model/cart.dart';
import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/cart/cartList.dart';
import 'package:flutter/material.dart';

class MyCart extends StatelessWidget {
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
              'Cart',
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
            Expanded(child: CartList()), // Sử dụng CartList ở đây

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Price :',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Color.fromRGBO(160, 160, 160, 1),
                      letterSpacing: 0.3),
                ),
                Text(
                  '744.89',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      letterSpacing: 0.3),
                ),
              ],
            ),
            CustomElevatedButton(text: "Buy now"),
          ],
        ),
      ),
    );
  }
}

class TotalPriceCalculator extends StatefulWidget {
  final int pricePerProduct;
  int quantity;
  TotalPriceCalculator(
      {Key? key, required this.pricePerProduct, required this.quantity})
      : super(key: key);

  @override
  _TotalPriceCalculatorState createState() => _TotalPriceCalculatorState();
}

class _TotalPriceCalculatorState extends State<TotalPriceCalculator> {
  void _increment() {
    setState(() {
      widget.quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (widget.quantity > 1) {
        widget.quantity--;
      }
    });
  }

  int get totalPrice => widget.quantity * widget.pricePerProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap:
                      _decrement, // Gọi hàm giảm số lượng khi nhấn vào biểu tượng minus
                  child: SizedBox(
                    width: 24, // Adjust the width of the image container
                    height: 24, // Adjust the height of the image container
                    child: Image.asset(
                      "assets/header-images/minus.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.quantity.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap:
                      _increment, // Gọi hàm tăng số lượng khi nhấn vào biểu tượng add
                  child: SizedBox(
                    width: 24, // Adjust the width of the image container
                    height: 24, // Adjust the height of the image container
                    child: Image.asset(
                      "assets/header-images/add.png",
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            '\$ $totalPrice',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CartItemUI extends StatefulWidget {
  final String id;
  final String imagePath;
  final String productName;
  final int quantity;
  final int pricePerProduct;
  final Function(String) onDeleteSuccess;

  const CartItemUI({
    Key? key,
    required this.id,
    required this.imagePath,
    required this.productName,
    required this.quantity,
    required this.pricePerProduct,
    required this.onDeleteSuccess,
  }) : super(key: key);

  @override
  _CartItemUIState createState() => _CartItemUIState();
}

class _CartItemUIState extends State<CartItemUI> {
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
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(widget.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              widget.productName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
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
                                          Cart.RemoveFromCart(
                                               widget.id);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('Delete success'),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          widget.onDeleteSuccess(widget.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Yes"),

                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      TotalPriceCalculator(
                        pricePerProduct: widget.pricePerProduct,
                        quantity: widget.quantity,
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
