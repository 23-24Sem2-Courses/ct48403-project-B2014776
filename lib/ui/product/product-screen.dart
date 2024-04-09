import 'package:ct484_project/ui/bottombar.dart';
import 'package:flutter/material.dart';

class MyProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 44.0,
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/header-images/backicon.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            // Handle when the icon is pressed
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                'https://www.bhphotovideo.com/images/images2500x2500/asus_k570ud_ds74_i7_8550u_8gb_1tb_256ssd_1405516.jpg',
              ),
            ),
            TitleSection(
              name: 'LAPTOP HP2GW59',
            ),
            Price(price: '27.000.00'),
            TextSection(
              description:
                  'degrees Celsius in the summer. Activities enjoyed here '
                  'include rowing, and riding the summer toboggan run.'
                  'djajkdkaaldla'
                  'djakldlaladaaa;da;dakaa;d;da'
                  'djakkadalkadjdakdjkjdafjakllkafllala'
                  'jksjkfjkakklakfjfhfjkakfjfhjfkakfkhsjsfkjk'
                  'dkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                  
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IncrementDecrementButtons(),
                SizedBox(width: 20), // Add spacing between buttons
                AddToCartButton(),
              ],
            ),
            
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({
    Key? key,
    required this.price,
  }) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    '$price\đ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 18,
        ),
        softWrap: true,
      ),
    );
  }
}

class IncrementDecrementButtons extends StatefulWidget {
  const IncrementDecrementButtons({Key? key}) : super(key: key);

  @override
  _IncrementDecrementButtonsState createState() =>
      _IncrementDecrementButtonsState();
}

class _IncrementDecrementButtonsState extends State<IncrementDecrementButtons> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

class AddToCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add product to cart
        // You can access the quantity from _counter
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        primary: Colors.black, // Màu nền của button
      ),
      child: Text(
        'Thêm sản phẩm',
        style: TextStyle(fontSize: 16, color: Colors.white), // Màu văn bản của button
      ),
    );
  }
}


