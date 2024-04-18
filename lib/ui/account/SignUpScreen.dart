import 'package:ct484_project/ui/account/component.dart';
import 'package:flutter/material.dart';


import '../../model/user.dart';
import '../home/screens-ui.dart';
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
  final TextEditingController _userSignupController = TextEditingController();

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
                return 'Please enter your username';
              }
              return null;
            },
            onChanged: (value) {
              // Handle value change if needed
            },
            controller: _userSignupController ,
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
            obscureText: true,
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
            onPressed: _signUp,
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

  Future<void> _signUp() async {

    String email = _emailSignupController.text;
    String password =  _passwordSignupController.text;
    String username= _userSignupController.text;
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username cannot be empty!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
      return; // Stop execution if email or password is empty
    }
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
    try{

      bool check = await signUpUser(username,email,password);
      if (check==true){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(' Sign up success'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }



    }
    catch (e){
      if (e.toString().contains('duplicate key error collection: mobile.users index: email_1')) {
        // Username already exists
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email is already taken! Please choose another one.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
      else   if (e.toString().contains('duplicate key error collection: mobile.users index: username_1 dup key')) {
        // Username already exists
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username is already taken! Please choose another one.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
      else {
        // Other error occurred
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign up failed  '),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
    }

  }



