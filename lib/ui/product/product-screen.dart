import 'package:ct484_project/model/cart.dart';
import 'package:flutter/material.dart';
import '../../model/product.dart';
import '../bottombar.dart';

class ProductDetail extends StatefulWidget {
  final String productId;

  const ProductDetail({required this.productId, super.key});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late Future<Product?> _futureProduct;

  @override
  void initState() {
    super.initState();
    _futureProduct = Product.getOneProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 44.0,
        centerTitle: true,
        titleSpacing: 0.0,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Product?>(
          future: _futureProduct,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final product = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TitleSection(name: product.productName),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Price(price: '${product.price} vnđ'),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IncrementDecrementButtons(),
                        ElevatedButton(
                          onPressed: () {
                            try{
                              int counterValue = const IncrementDecrementButtons().counterValue;
                              Cart.addToCart( widget.productId, counterValue.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Add to cart success:'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                            catch (e){

                            }
                          },
                          child: Text('Add to cart'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextSection(description: product.productDescription),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;

  const TitleSection({required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        IconButton(
          iconSize: 30.0,
          icon: Icon(Icons.favorite_border),
          onPressed: () {
            // Add your favorite action here
          },
        ),
      ],
    );
  }
}

class Price extends StatelessWidget {
  final String price;

  const Price({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  final String description;

  const TextSection({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 18,
      ),
      softWrap: true,
    );
  }
}

class IncrementDecrementButtons extends StatefulWidget {
  const IncrementDecrementButtons({Key? key}) : super(key: key);

  @override
  _IncrementDecrementButtonsState createState() =>
      _IncrementDecrementButtonsState();
  int get counterValue => _IncrementDecrementButtonsState()._counter;
}

class _IncrementDecrementButtonsState extends State<IncrementDecrementButtons> {
  int _counter = 1;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  int get counterValue => _counter;

  void _decrement() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text(
          '$_counter',
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
