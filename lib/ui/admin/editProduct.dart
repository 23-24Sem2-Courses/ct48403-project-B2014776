import 'dart:io';

import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/product.dart';

class EditProduct extends StatelessWidget {
  final Product product;

  const EditProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44.0), // Đặt chiều cao cho AppBar
        child: MyAppBar(),
      ),
      body: AddPageContent(
        product: product,
      ),
    );
  }
}

class AddPageContent extends StatefulWidget {
  final Product product;

  const AddPageContent({Key? key, required this.product}) : super(key: key);

  @override
  _AddPageContentState createState() => _AddPageContentState();
}

class _AddPageContentState extends State<AddPageContent> {
  final TextEditingController _ProductController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  File? _Selectimage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ProductController.text = widget.product.productName.toString();
    _PriceController.text = widget.product.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  'PRODUCT NAME :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ]),
            ),
            InputFormField(
              hintText: 'Enter the product name',
              controller: _ProductController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  'PRICE :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ]),
            ),
            InputFormField(
              hintText: 'Enter the price',
              controller: _PriceController,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  'CATEGORY :',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ]),
            ),

            ProductCategoryDropdown(),

            ElevatedButton(
              onPressed: () {
                _pickImageFromGallery();
              },
              child: Text('Select Image'),
            ),

            // Hiển thị ảnh được chọn
            if (_Selectimage != null)
              Image.file(
                _Selectimage!,
                width: 200,
                height: 200,
              ),
            if (_Selectimage == null)
              Image.network(
                widget.product.imageUrl.toString(),
                width: 200,
                height: 200,
              ),
            CustomElevatedButton(
                text: "Edit Product",
                onPressed: () {
                  Product editPro = Product(
                      id: widget.product.id,
                      productName: _ProductController.text,
                      productDescription: "",
                      price: double.parse(_PriceController.text));

                  try {
                    if (_Selectimage != null) {
                      Product.updateProduct(editPro, _Selectimage);
                    } else {
                      Product.updateProduct(editPro, null);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('update success:'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    // Handle errors or exceptions
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('update failed: $e'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;
    setState(() {
      _Selectimage = File(pickedImage.path);
    });
  }
}

class ProductCategoryDropdown extends StatefulWidget {
  @override
  _ProductCategoryDropdownState createState() =>
      _ProductCategoryDropdownState();
}

class _ProductCategoryDropdownState extends State<ProductCategoryDropdown> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text('Select Category'),
            ),
            value: _selectedCategory,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            items: <String>['Laptop', 'Phone', 'Devices'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
