import 'package:ct484_project/model/product.dart';
import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../model/category.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), // Set the height for AppBar
        child: MyAppBar(),
      ),
      body: AddPageContent(),
    );
  }
}

class AddPageContent extends StatefulWidget {

  const AddPageContent({Key? key});

  @override
  _AddPageContentState createState() => _AddPageContentState();
}

class _AddPageContentState extends State<AddPageContent> {
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  String? _selectedCategory;

  void _handleCategorySelected(String? selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  void clearFields() {
    _productController.text = "";
    _priceController.text = "";
    _selectedImage = null;
    _selectedCategory = null;
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
              controller: _productController,
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
              controller: _priceController,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(children: [
                Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _descriptionController,
                maxLines: 5, // Adjust this value as needed
                decoration: InputDecoration(
                  hintText: 'Enter the product description',
                  border: OutlineInputBorder(),
                ),
              ),
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

            ProductCategoryDropdown(
              onCategorySelected: _handleCategorySelected,
            ),

            ElevatedButton(
              onPressed: () {
                _pickImageFromGallery();
              },
              child: Text('Select Image'),
            ),

            // Display the selected image
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                width: 200,
                height: 200,
              ),
            CustomElevatedButton(
              text: "Add Product",
              onPressed: _isLoading
                  ? null
                  : () {
                if (_productController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter the product name please'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (_priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter the product price please'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                double? price = double.tryParse(_priceController.text);
                if (price == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid price. Please enter a valid number.'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (_selectedCategory == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Select the product category please'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                Product newProduct = Product(
                  productName: _productController.text,
                  productDescription: _descriptionController.text,
                  price: double.parse(_priceController.text),
                  category: _selectedCategory!,
                );
                if (_selectedImage != null) {
                  try {
                    Product.addProduct(newProduct, _selectedImage!);
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product added successfully'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                    clearFields();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to add product'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }
}

class ProductCategoryDropdown extends StatefulWidget {
  final void Function(String?) onCategorySelected;

  const ProductCategoryDropdown({Key? key, required this.onCategorySelected});

  @override
  _ProductCategoryDropdownState createState() => _ProductCategoryDropdownState();
}

class _ProductCategoryDropdownState extends State<ProductCategoryDropdown> {
  String? _selectedCategory;
  List<Category> _categories = [];

  Future<void> _loadCategories() async {
    try {
      List<Category> categories = await Category.fetchCategories();
      setState(() {
        _categories = categories;
      });
    } catch (error) {
      print('Error loading categories: $error');
      // Handle error, e.g., show error message to user
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _handleCategorySelected(String? newValue) {
    setState(() {
      _selectedCategory = newValue;
    });
    // Call the callback function to notify the parent widget
    widget.onCategorySelected(newValue);
  }

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
              _handleCategorySelected(newValue);
            },
            items: _categories.map((Category category) {
              return DropdownMenuItem<String>(
                value: category.id,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(category.name),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
