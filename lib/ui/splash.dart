import 'dart:async';
import 'dart:convert';
import 'package:ct484_project/ui/account/loginScreen.dart';
import 'package:ct484_project/ui/admin/admin.dart';
import 'package:ct484_project/ui/home/screens-ui.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Check if the token and user exist in shared preferences
    _checkUserLoggedIn();
  }

  // Function to check if the user is logged in
// Function to check if the user is logged in
  Future<void> _checkUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token_login');
    final userString = prefs.getString('user');

    if (token != null && userString != null) {
      final user = jsonDecode(userString);
      final role = user['role'];

      if (role != null) {
        if (role == 'admin') {
          // Navigate to admin screen
          Timer(Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminList()),
            );
          });
        } else {
          // Navigate to customer screen
          Timer(Duration(seconds: 3), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Screens()), // Assuming this is the customer screen
            );
          });
        }
      } else {
        // If role is not defined, navigate to login screen
        Timer(Duration(seconds: 3), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        });
      }
    } else {
      // If token or user is null, navigate to login screen
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 150),
            SizedBox(height: 20),
            Text(
              'Welcome to My Shop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
