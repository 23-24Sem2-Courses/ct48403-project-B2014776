import 'package:ct484_project/ui/account/component.dart';
import 'package:flutter/material.dart';


import 'loginScreen.dart';



class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SignUpPageContent(),
    );
  }
}
class SignUpPageContent extends StatefulWidget {
  const SignUpPageContent({super.key});

  @override
  _SignUpContentState createState() => _SignUpContentState();
}

class _SignUpContentState extends State< SignUpPageContent> {
   final TextEditingController _emailSignupController = TextEditingController();
  final TextEditingController _passwordSignupController = TextEditingController();




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
              'Create Your Account',
              style: TextStyle(
                fontSize: 24,
                height: 1.2,
                fontWeight: FontWeight.w700,

              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Which part of country that you call home?',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                letterSpacing: .3,

              ),
            ),
          ),


          InputFormField(
            hintText: 'Enter username',

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
            hintText: 'Enter your email',
            controller: _emailSignupController,
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
            controller: _passwordSignupController,
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


          const DividerSeparator(
            thickness: 0.5,
            height: 20.0,
            textLabel: "Or sign in with",

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
          CustomElevatedButton(
            text: 'Sign up',
            onPressed: _signIn,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 60, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    'Already have an account ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),




                GestureDetector(
                  onTap: () {
                    // Navigate to the sign-up page or perform any action here
                    // For now, navigate to the login page again

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  const LoginPage()),
                    );
                  },
                  child:

                 const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      'Sign In',
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

  void _signIn() {
    String password_mock = "123";
    String email_mock = "linh@gmail.com";
    String email = _emailSignupController.text;
    String password =  _passwordSignupController.text;
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
    if (password == password_mock && email == email_mock) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login success'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}


