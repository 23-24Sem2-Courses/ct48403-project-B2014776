import 'dart:convert';
import 'dart:io';
import 'package:ct484_project/model/cart.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

String baseUrl = "https://mobile-backend-latest.onrender.com/api/v1";

String baseUrlImage = "https://mobile-backend-latest.onrender.com";
class Product {
  final String? id;
  final String? category;
  final String productName;
  final String productDescription;
  String ? imageUrl;
  final double price;

  Product({
    this.category,
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
      price: _parsePrice(json['price']),
      category: _parseCategory(json['category'])
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
      final Map<String, dynamic> jsonData = jsonDecode(response.body); // Parse as map
      final List<dynamic> productList = jsonData['products']; // Access the 'products' key containing the list of products
      return productList.map((itemJson) => Product.fromJson(itemJson)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }
  static Future<List<Product>> searchProducts(String query) async {
    final apiUrl = 'https://mobile-backend-latest.onrender.com/api/v1/products?search=$query';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('check ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body); // Parse as map
        final List<dynamic> productList = jsonData['products']; // Access the 'products' key containing the list of products
        return productList.map((itemJson) => Product.fromJson(itemJson)).toList();
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
  static Future<List<Product>> fetchLaptopProducts() async {
    final apiUrl = baseUrl + '/products/category/laptop'; // Use baseUrl here
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {

      final List<dynamic> jsonData = jsonDecode(response.body);
      print(jsonData);
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
  static Future<void> deleteProductById(String productId) async {
    final apiUrl = '$API_BASE_URL/products/$productId';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else if (response.statusCode == 404) {
        print('Product not found');
      } else {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
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
      request.fields["category"] = newProduct.category.toString();
      request.fields["quantity"]="1";


        var imageStream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile('image', imageStream, length, filename: basename(imageFile.path));
        request.files.add(multipartFile);


      // Send the request
      var streamedResponse = await request.send();

      // Get the response
      var response = await http.Response.fromStream(streamedResponse);

      // Check the response status
      if (response.statusCode != 201) {

          throw Exception('Failed to add product. Server responded with status code ${response.statusCode}. Message: ${response.body}');

      }
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  // Method to update a product with image file
  static Future<void> updateProduct(Product updatedProduct,
      File? imageFile) async {


    final apiUrl = baseUrl + '/products/${updatedProduct.id}';

    try {
      print(' category ${updatedProduct.category}');
      // Create a multipart request
      var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
      request.fields['name'] = updatedProduct.productName;
      request.fields['description'] = updatedProduct.productDescription;
      request.fields['price'] = updatedProduct.price.toString();
      request.fields["category"] = updatedProduct.category.toString();
      // Add image file
      if (imageFile != null) {
        var imageStream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile('image', imageStream, length, filename: basename(imageFile.path));
        request.files.add(multipartFile);
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
  static double _parsePrice(dynamic value) {
    if (value is num) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }
  static String? _parseCategory(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is Map<String, dynamic>) {
      return value['_id'];
    } else {
      return null;
    }
  }
}
