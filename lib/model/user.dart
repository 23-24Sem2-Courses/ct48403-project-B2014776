import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    switch (json.runtimeType) {
      case const (Map<String, dynamic>):
        return User(
          id: json['_id'],
          username: json['username'],
          email: json['email'],
          password: json['password'],
          role: json['role'],
          createdAt: DateTime.parse(json['createdAt']),
          updatedAt: DateTime.parse(json['updatedAt']),
        );
      default:
        throw FormatException('Invalid JSON type for User: ${json.runtimeType}');
    }
  }
}



Future<User> fetchUser()async{
  const apiUrl="https://mobile-backend-v1.onrender.com/api/v1/users";
  final response=await http.get(Uri.parse(apiUrl));
  if(response.statusCode==200){
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  const apiUrl = "https://mobile-backend-v1.onrender.com/api/v1/users/login";
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({"email": email, "password": password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token_login', responseData['token']);
      await prefs.setString('user', jsonEncode(responseData['user']));
      return {
        'user': responseData['user'],
        'token': responseData['token'],
      };




    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  } catch (e) {
    // Handle exceptions or errors here
    print('Error: $e');
    throw Exception('Failed to login: $e');
  }
}

Future<void> logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("token_login");
  await prefs.remove("user");

}

Future<Map<String, dynamic>> signUpUser(
    String username, String email, String password) async {
  const apiUrl =
      "https://mobile-backend-v1.onrender.com/api/v1/users";
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({"username": username, "email": email, "password": password}),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 10)); // Add timeout for the request

    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token_login', responseData['token']);
      await prefs.setString('user', jsonEncode(responseData['user']));
      return {
        'user': User.fromJson(responseData['user']),
        'token': responseData['token'],
      };
    } else {
      throw Exception('Failed to sign up: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to sign up: $e');
  }
}