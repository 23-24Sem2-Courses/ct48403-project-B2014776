import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10), // Thêm top vào đây
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 23, 22, 22)),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
        ));
  }
}
