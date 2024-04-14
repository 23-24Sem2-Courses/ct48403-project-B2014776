import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/bottombar.dart';
import 'package:flutter/material.dart';

class MyProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 44.0,
        centerTitle: true, // Đặt tiêu đề ở giữa
        titleSpacing: 0.0, // Loại bỏ khoảng cách giữa nút trở lại và tiêu đề
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
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                'https://th.bing.com/th/id/OIP.1klT6vw4oxx5tA2V7hLPWQHaHa?rs=1&pid=ImgDetMain',
              ),
            ),
            TitleSection(
              name: 'Laptop',
            ),
            Price(price: '27.758'),
            Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 15, top: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IncrementDecrementButtons(),
                  SizedBox(width: 20), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      // Your button action here
                    },
                    child: Text(
                      'Add to cart',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Màu nền của nút
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Bo tròn góc của nút
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12), // Kích thước padding
                    ),
                  )
                ],
              ),
            ),
            TextSection(
                description:
                    'degrees Celsius in the summer. Activities enjoyed here '
                    'include rowing, and riding the summer toboggan run.'),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class TitleSection extends StatefulWidget {
  final String name;

  const TitleSection({required this.name});

  @override
  _TitleSectionState createState() => _TitleSectionState();
}

class _TitleSectionState extends State<TitleSection> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Đặt các phần tử nằm ở hai bên
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
          ),
          IconButton(
            iconSize: 30.0, // Đặt kích thước của icon
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.black : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorited = !isFavorited;
              });
            },
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
      padding: const EdgeInsets.only(top: 0, bottom: 5, left: 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    '$price',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
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
      padding: const EdgeInsets.all(10),
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
      if (_counter > 1) {
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
