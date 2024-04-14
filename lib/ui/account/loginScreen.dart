import 'package:ct484_project/ui/account/SignUpScreen.dart';
import 'package:ct484_project/ui/account/component.dart';
import 'package:ct484_project/ui/admin/admin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';
import '../home/screens-ui.dart';




class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: LoginPageContent(),
    );
  }
}
class LoginPageContent extends StatefulWidget {
  const LoginPageContent({Key? key}) : super(key: key);

  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
            child: Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Sign in',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InputFormField(
            hintText: 'Enter your email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (value) {
              // Handle value change if needed
            },
          ),
          InputFormField(
            hintText: 'Enter your password',
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) {
              // Handle value change if needed
            },
          ),
          const ForgetPassword(),
          CustomElevatedButton(
            text: 'Sign in',
            onPressed: _signIn,
          ),
          const DividerSeparator(
            thickness: 0.5,
            height: 20.0,
            textLabel: "OR",
          ),
          FacebookSignInButton(
            onPressed: () {
              // Add onPressed action here
            },
          ),
          GoogleSignInButton(
            onPressed: () {
              // Add onPressed action here
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 60, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'Don’t have an account ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {

                    // Navigate to the sign-up page replacing the current page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>const SignUpPage()),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn () async {

    if (!mounted) {
      // The widget is disposed, do not proceed
      return;
    }
    String email = _emailController.text;
    String password = _passwordController.text;
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email cannot be empty!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return; // Stop execution if email or password is empty
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password cannot be empty!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return; // Stop execution if email or password is empty
    }
    try {
      // Call the loginUser function
      Map<String, dynamic> loginData = await loginUser(email, password);
      String role=loginData["user"]["role"].toString();
      if(role=="admin"){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login succes'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AdminList()),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login succes'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );


      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Screens()),
      );




    } catch (e) {
      // Handle errors or exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );

    }
  }
}


