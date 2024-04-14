import 'dart:convert';
import 'package:ct484_project/model/product.dart';
import 'package:http/http.dart' as http;
String API_BASE_URL="https://mobile-backend-latest.onrender.com/api/v1";
class Cart {
  final String id;
  final String userId;
  final List<CartItem> products;

  Cart({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['_id'],
      userId: json['user'],

      products: (json['products'] as List<dynamic>)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  static Future<Cart> createUserCart(String userId) async {
    final apiUrl = '$API_BASE_URL/createUserCart'; // Replace with your API endpoint
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return Cart.fromJson(jsonData);
      } else {
        throw Exception('Failed to create user cart: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create user cart: $e');
    }
  }

  static Future<Cart> addToCart(String userId, String productId, String quantity) async {
    final apiUrl = '$API_BASE_URL/cart/${userId.toString()}';
    print(apiUrl);// Replace with your API endpoint
    try {
      print('productId: $productId');
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'productId': productId, 'quantity': int.parse(quantity)}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Cart.fromJson(jsonData);
      } else {
        throw Exception('Failed to add to cart: ${response.statusCode}  ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }


  static Future<Cart> RemoveFromCart(String userId, String productId,) async {
    final apiUrl = '$API_BASE_URL/cart/products';

    print(apiUrl);// Replace with your API endpoint
    try {
      print('productId: $productId');
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'productId': productId}),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return Cart.fromJson(jsonData);
      } else {
        throw Exception('Failed to delete to cart: ${response.statusCode}  ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to delete to cart: $e');
    }
  }


  static Future<Cart> clearCart(String userId) async {
    final url = Uri.parse('$API_BASE_URL/clearCart');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId}),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to clear cart: ${response.statusCode}');
    }
  }

  static Future<Cart> getUserCart(String userId) async {
    final url = Uri.parse('$API_BASE_URL/cart/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user cart: ${response.statusCode}');
    }
  }

  // Add other methods like removeFromCart, clearCart, and getUserCart similarly
}

class CartItem {
  final String productId;
  final int quantity;
  final Product product; // Include the complete product information here

  CartItem({
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product']['_id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']), // Parse the product details
    );
  }
}

