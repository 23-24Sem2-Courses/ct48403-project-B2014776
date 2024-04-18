import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:ct484_project/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<void> addToWishlist(String productId) async {

    try {
      final apiUrl = '$baseUrl/wishlist/'; // Replace with your API endpoint
      final prefs = await SharedPreferences.getInstance();
      String? userDataString = prefs.getString('user');
      if(userDataString!=null){
        Map<String, dynamic> userData = jsonDecode(userDataString);

        String userId=userData['_id'];

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId, 'productId': productId}),
        );
        if (response.statusCode != 200) {
          throw Exception('Failed to add to wishlist: ${response.statusCode}');
        }
      }



    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  static Future<void> removeFromWishlist( String productId) async {

    try {

      final apiUrl = '$baseUrl/wishlist/'; // Replace with your API endpoint
      final prefs = await SharedPreferences.getInstance();
      String? userDataString = prefs.getString('user');
      if(userDataString!=null){
        Map<String, dynamic> userData = jsonDecode(userDataString);

        String userId=userData['_id'];

        final response = await http.delete(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'userId': userId, 'productId': productId}),
        );
        if (response.statusCode != 200) {
          throw Exception('Failed to add to wishlist: ${response.statusCode}');
        }


          if (response.statusCode != 200) {
            throw Exception('Failed to remove from wishlist: ${response.statusCode}');
          }
      }
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  static Future<List<Product>> getUserWishlist() async {

    try {
      final prefs = await SharedPreferences.getInstance();
      String? userDataString = prefs.getString('user');
      if(userDataString!=null){
        Map<String, dynamic> userData = jsonDecode(userDataString);

        String userId=userData['_id'];
        final apiUrl = '$baseUrl/wishlist/$userId'; // Replace with your API endpoint
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = jsonDecode(response.body);
          return jsonData.map((itemJson) => Product.fromJson(itemJson)).toList();
        } else {
          throw Exception('Failed to get user wishlist: ${response.statusCode}');
        }
      }
      else{
        throw Exception('Failed to get user wishlist:');

      }

    } catch (e) {
      throw Exception('Failed to get user wishlist: $e');
    }
  }
}
