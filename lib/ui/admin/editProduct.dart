import 'dart:io';

import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/category.dart';
import '../../model/product.dart';

class EditProduct extends StatelessWidget {
  final Product product;

  const EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44.0), // Set the height for AppBar
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
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  String? _selectedCategory;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _productController.text = widget.product.productName.toString();
    _priceController.text = widget.product.price.toString();
    _descriptionController.text = widget.product.productDescription.toString();
    _selectedCategory = widget.product.category.toString();
    _loadCategories();
  }

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

  void _handleCategorySelected(String? newValue) {
    setState(() {
      _selectedCategory = newValue;
    });
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
                  'DESCRIPTION :',
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
              categories: _categories,
              selectedCategory: _selectedCategory,
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
            if (_selectedImage == null)
              Image.network(
                widget.product.imageUrl.toString(),
                width: 200,
                height: 200,
              ),
            CustomElevatedButton(
              text: "Edit Product",
              onPressed: () {
                Product editedProduct = Product(
                  id: widget.product.id,
                  productName: _productController.text,
                  productDescription: _descriptionController.text,
                  price: double.parse(_priceController.text),
                  category: _selectedCategory,
                );

                try {
                  if (_selectedImage != null) {
                    Product.updateProduct(editedProduct, _selectedImage);
                  } else {
                    Product.updateProduct(editedProduct, null);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('update success:'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('update failed: $e'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
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

class ProductCategoryDropdown extends StatelessWidget {
  final List<Category> categories;
  final String? selectedCategory;
  final void Function(String?) onCategorySelected;

  const ProductCategoryDropdown({
    Key? key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

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
            value: selectedCategory,
            onChanged: (String? newValue) {
              onCategorySelected(newValue);
            },
            items: categories.map((Category category) {
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
