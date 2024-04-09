import 'package:flutter/material.dart';

class MyTag extends StatelessWidget {
  const MyTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key, // Thêm key vào Container
      width: 375,
      height: 50,
      margin: EdgeInsets.only(top: 5, left: 0),
        
      child: Row(
        children: [
          SizedBox(width: 15), // Khoảng cách từ lề trái của container
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ButtonTag(text: 'All'),
                  SizedBox(width: 10),
                  ButtonTag(text: 'Phones'),
                  SizedBox(width: 10),
                  ButtonTag(text: 'Laptops'),
                  SizedBox(width: 10),
                  ButtonTag(text: 'Devices'),
                  SizedBox(width: 10),
              
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonTag extends StatelessWidget {
  final String text;

  const ButtonTag({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      child: TextButton( // Thay thế FlatButton bằng TextButton
        onPressed: () {
          // Xử lý khi nút được nhấn
        },
        child: Text(text,
        style: TextStyle(color: Colors.black),
        
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(width: 1, color:  Color.fromARGB(255, 23, 22, 22) ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ),
    );
  }
}
