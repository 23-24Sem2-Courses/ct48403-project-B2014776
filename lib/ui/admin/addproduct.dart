import 'package:ct484_project/model/product.dart';
import 'package:ct484_project/ui/account/SignUpScreen.dart';
import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/home/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../model/category.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0), // Đặt chiều cao cho AppBar
        child: MyAppBar(),
      ),
      body: AddPageContent(),
    );
  }
}

class AddPageContent extends StatefulWidget {
  const AddPageContent({super.key});
// oke t van treo ultra a
  @override
  _AddPageContentState createState() => _AddPageContentState();
}

class _AddPageContentState extends State<AddPageContent> {
  final TextEditingController _ProductController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  File? _Selectimage;
  bool _isLoading = false;

  String? _selectedCategory;

  void _handleCategorySelected(String? selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
    // You can perform further actions with the selected category here
  }


  void clear_fields(){
    _ProductController.text="";
    _PriceController.text="";
    _Selectimage=null;
    _selectedCategory=null;
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

            ProductCategoryDropdown(
              onCategorySelected: _handleCategorySelected
            ),

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
            CustomElevatedButton(text: "Add Product",
            onPressed: _isLoading
                ? null
                :(){

              if(_ProductController.text==""){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter the product name please'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (_PriceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter the product price please'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              double? price = double.tryParse(_PriceController.text);
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

              if ( _selectedCategory==null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Select the product category please'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              Product new_product=new Product(productName: _ProductController.text, productDescription: _PriceController.text, price: double.parse (_PriceController.text),category: _selectedCategory);
              if(_Selectimage!=null){
                try {
                  Product.addProduct(new_product, _Selectimage!);
                  setState(() {
                    _isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Update succes'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                  clear_fields();

                }

                catch (e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Update failed'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },),
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
  final void Function(String?) onCategorySelected;

  const ProductCategoryDropdown({super.key, required this.onCategorySelected});
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
    // TODO: implement initState
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

              widget.onCategorySelected(newValue);
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
