import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:ct484_project/model/product.dart';

class Wishlist {
  final String userId;
  final List<Product> products;

  Wishlist({
    required this.userId,
    required this.products,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      userId: json['user'],
      products: (json['products'] as List<dynamic>)
          .map((item) => Product.fromJson(item))
          .toList(),
    );
  }

  static Future<void> addToWishlist(String userId, String productId) async {
    final apiUrl = '$baseUrl/addToWishlist'; // Replace with your API endpoint
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'productId': productId}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add to wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  static Future<void> removeFromWishlist(String userId, String productId) async {
    final apiUrl = '$baseUrl/removeFromWishlist'; // Replace with your API endpoint
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId, 'productId': productId}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to remove from wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  static Future<List<String>> getUserWishlist(String userId) async {
    final apiUrl = '$baseUrl/getUserWishlist/$userId'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return List<String>.from(jsonData);
      } else {
        throw Exception('Failed to get user wishlist: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get user wishlist: $e');
    }
  }
}
