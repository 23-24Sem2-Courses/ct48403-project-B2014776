import 'package:flutter/material.dart';


  class InputFormField extends StatefulWidget {
    final String? hintText;
    final bool obscureText;
    final String? Function(String?)? validator;
    final void Function(String)? onChanged;
    final TextEditingController? controller;
    final String? errorText;
    const InputFormField({
      super.key,
      this.errorText,
      required this.hintText,
      this.validator,
      this.onChanged,
      this.controller,
      this.obscureText=false
    });

    @override
    _InputFormFieldState createState() => _InputFormFieldState();
  }

  class _InputFormFieldState extends State<InputFormField> {
    late TextEditingController _textController;
    bool _isObscure = true; // Trạng thái che mật khẩu1
    @override
    void initState() {
      super.initState();
      _textController = widget.controller ?? TextEditingController();
      // _isObscure = widget.obscureText; // Khởi tạo giá trị trạng thái ẩn/mở mật khẩu
    }

    @override
    void dispose() {
      _textController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: TextFormField(
            controller: _textController,
            onChanged: widget.onChanged,
            validator: widget.validator,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "Inter",
              letterSpacing: 0.3,
              fontWeight: FontWeight.w400,
            ),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              hintText: widget.hintText,
                errorText:widget.errorText,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(12)),

              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              )
                  : null,
            ),

          ),
        ),
      );
    }
  }


  class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});



    @override
    Widget build(BuildContext context) {
      return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
                  onTap: () {
                // Navigate to the sign-up page or perform any action here
                // For now, navigate to the login page again
             
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 20, bottom: 5), // Add padding here
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),



      )
      );

    }
  }

  class CustomElevatedButton extends StatelessWidget {
    final String text;
    final VoidCallback? onPressed;
    final double height;
    final double borderRadius;
    final Color backgroundColor;
    final Color textColor;

    const CustomElevatedButton({
      super.key,
      required this.text,
      this.onPressed,
      this.height = 56,
      this.borderRadius = 16,
      this.backgroundColor = Colors.black,
      this.textColor = Colors.white,
    });

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SizedBox(
          width: double.infinity, // Set the width here
          height: height,

          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius), // Set border radius here
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
              ),
            ),
          ),
        ),
      );
    }
  }



  class DividerSeparator extends StatelessWidget {
    final double height;
    final double thickness;
    final Color color;
    final String textLabel ;

    const DividerSeparator({
      super.key,
      this.height = 0.0,
      this.thickness = 1.0,
      this.color = Colors.grey,
      required this.textLabel
    });

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: height),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: color,
                thickness: thickness,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                   textLabel,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Inter",
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: color,
                thickness: thickness,
              ),
            ),
          ],
        ),
      );
    }
  }

  class FacebookSignInButton extends StatelessWidget {
    final VoidCallback onPressed;

    const FacebookSignInButton({super.key, required this.onPressed});

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SizedBox(
          width: double.infinity, // Set the width here
          height: 52,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set background color here
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24), // Set border radius here
                  side: const BorderSide(color: Color.fromRGBO(191, 191, 191, 1.0), width: 1),
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.facebook,
                  color: Colors.blue, // Set icon color here
                  size: 24, // Set icon size here
                ),
                SizedBox(width: 8), // Add some spacing between icon and text
                Text(
                  'Continue with Facebook',
                  style: TextStyle(
                    color: Color.fromRGBO(87, 87, 87, 1),
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    letterSpacing: 0.3,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }




  class GoogleSignInButton extends StatelessWidget {
    final VoidCallback onPressed;

    const GoogleSignInButton({super.key, required this.onPressed});

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SizedBox(
          width: double.infinity, // Set the width here
          height: 52,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set background color here
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24), // Set border radius here
                  side: const BorderSide(color: Color.fromRGBO(191, 191, 191, 1.0), width: 1),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24, // Adjust the width of the image container
                  height: 24, // Adjust the height of the image container
                  child: Image.network(
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8), // Add some spacing between icon and text
                const Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: Color.fromRGBO(87, 87, 87, 1),
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    letterSpacing: 0.3,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }



  class ForgetPasswordButton extends StatelessWidget{
    final VoidCallback onPressed;
  const ForgetPasswordButton({super.key,required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: SizedBox(
        width: double.infinity, // Set the width here
        height: 138,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set background color here
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24), // Set border radius here
                side: const BorderSide(color: Color.fromRGBO(191, 191, 191, 1.0), width: 1),
              ),
            ),
          ),
          child:

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0,top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40, // Adjust the width of the image container
                      height: 40, // Adjust the height of the image container

                      child: Image.asset("assets/email.png",
                        width: 40,
                        height: 40,
                      ),
                    ),

                    SizedBox(
                      width: 24, // Adjust the width of the image container
                      height: 24, // Adjust the height of the image container
                      child: Image.asset("assets/check.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),

             const Padding(
                padding:  EdgeInsets.only(top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Color.fromRGBO(87, 87, 87, 1),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                        letterSpacing: 0.3,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your email: *****dyne@mail.com',
                    style: TextStyle(
                      color: Color.fromRGBO(87, 87, 87, 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      letterSpacing: 0.3,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }

  }