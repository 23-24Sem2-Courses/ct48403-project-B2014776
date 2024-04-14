import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "https://mobile-backend-latest.onrender.com/api/v1";

String baseUrlImage = "https://mobile-backend-latest.onrender.com";
class Product {
  final String? id;
  final String productName;
  final String productDescription;
  String ? imageUrl;
  final double price;

  Product({
    this.id,
    required this.productName,
    required this.productDescription,
    this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('_id') ||
        !json.containsKey('name') ||
        !json.containsKey('description') ||
        !json.containsKey('image') ||
        !json.containsKey('price')) {
      throw FormatException('Invalid JSON data for Product: $json');
    }

    return Product(
      id: json['_id'],
      productName: json['name'],
      productDescription: json['description'],
      imageUrl: "$baseUrlImage/uploads/" + json['image'],
      // Use baseUrl here
      price: json['price'].toDouble(),
    );
  }

  static Future<Product?> getOneProduct(String productId) async {
    final apiUrl = '$baseUrl/products/$productId';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Product.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        // Product not found
        return null;
      } else {
        throw Exception('Failed to fetch product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  static Future<List<Product>> fetchAllProducts() async {
    final apiUrl = baseUrl + '/products'; // Use baseUrl here
    print("api: " + apiUrl);

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((itemJson) => Product.fromJson(itemJson)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }

  static Future<List<Product>> fetchLaptopProducts() async {
    final apiUrl = baseUrl + '/products/category/laptop'; // Use baseUrl here
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((itemJson) => Product.fromJson(itemJson)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }


  static Future<List<Product>> fetchSmartPhoneProducts() async {
    final apiUrl = baseUrl +
        '/products/category/smart_phone'; // Use baseUrl here
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((itemJson) => Product.fromJson(itemJson)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }


  static Future<List<Product>> fetchAccessoriesProducts() async {
    final apiUrl = baseUrl +
        '/products/category/accessories'; // Use baseUrl here
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((itemJson) => Product.fromJson(itemJson)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }

  static Future<void> addProduct(Product newProduct, File imageFile) async {
    final apiUrl = baseUrl + '/products';
    try {
      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      // Add product data
      request.fields['name'] = newProduct.productName;
      request.fields['description'] = newProduct.productDescription;
      request.fields['price'] = newProduct.price.toString();

      // Add image file
      request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path));

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode != 201) {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  // Method to update a product with image file
  static Future<void> updateProduct(Product updatedProduct,
      File? imageFile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginToken = prefs.getString("token_login");
    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $loginToken',
    };
    final apiUrl = baseUrl + '/products/${updatedProduct.id}';

    try {
      // Create a multipart request
      var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
      request.headers.addAll(headers);

      // Add product data
      request.fields['name'] = updatedProduct.productName;
      request.fields['description'] = updatedProduct.productDescription;
      request.fields['price'] = updatedProduct.price.toString();

      // Add image file
      if (imageFile != null) {
        request.files.add(
            await http.MultipartFile.fromPath('image', imageFile.path));
      }

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        print('Product updated successfully');
      } else {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }
}
