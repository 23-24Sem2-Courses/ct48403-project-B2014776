import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productDescription;
  final String imageUrl;
  final double price;
  final VoidCallback onPressed;

  const ProductCard({super.key,
    required this.productName,
    required this.productDescription,
    required this.imageUrl,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 217,
      width: 163.0,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child:

          Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,


              children: [
                    Padding(
                 padding: const EdgeInsets.all(10),
                child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        SizedBox(
                          width: 24, // Adjust the width of the image container
                          height: 24, // Adjust the height of the image container
                          child: Image.asset("assets/header-images/iconFvr.png",
                            width: 40,
                            height: 40,
                            
                          ),
                        ),



                      ],
          ),
        )
,
                Container(
                  decoration: const BoxDecoration(

                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.1), // Top color (semi-transparent black)
                        Color.fromRGBO(0, 0, 0, 0),   // Bottom color (fully transparent)
                      ],
                    ), // Set background color with opacity
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2), // Shadow color
                      spreadRadius: 0,  // Spread radius
                      blurRadius: 4,    // Blur radius
                      offset: Offset(0, 4), // Offset in the positive y-direction
                    ),
                  ]
                  ),
                  child: Padding(

                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                          Text(
                            productName,
                            style: const TextStyle(
                              color: Colors.white, // Text color for product name
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),


                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              style:  const TextStyle(
                                color: Colors.white, // Text color for product name
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              price.toString(),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(
                              width: 24, // Adjust the width of the image container
                              height: 24, // Adjust the height of the image container
                              child: Image.asset("assets/header-images/iconGiohang.png",
                                width: 40,
                                height: 40,
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                )

              ]

          )
///
        ),
      ),
    );
  }
}
