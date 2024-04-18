import 'package:http/http.dart' as http;
import 'dart:convert';
String API_BASE_URL="https://mobile-backend-latest.onrender.com/api/v1";

class Category {
  final String id;
  final String name;
  final String? description;

  Category({
    required this.id,
    required this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }
   static Future<List<Category>> fetchCategories() async {
    final apiUrl = '$API_BASE_URL/category'; // Replace with your API endpoint
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((category) => Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (error) {
      throw Exception('Error fetching categories: $error');
    }
  }
}
