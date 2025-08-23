import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class AddressDetailsScreen extends StatelessWidget {
  const AddressDetailsScreen({super.key});

  final List<String> addresses = const [
    'undefined, 165 8 Najafgarh Prem nagar, New Delhi,\nDelhi–110043',
    'undefined, 8 7 , 7,\n–110043',
    'Gali no 8 prem nagar najafgarh , Moksh Recharge Centre G Block,\nRohan vastra bhandar\nDelhi,\nDelhi–110043',
    'undefined, 165 8 Najafgarh Prem nagar,\nDelhi,\nDelhi–110043',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = size.width * 0.04; // 4% horizontal padding
    final double cardSpacing = size.height * 0.010; // 1.5% vertical spacing

    return Scaffold(
      appBar: CustomAppBar(
        titleText: "My Address",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(padding),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: cardSpacing),
                      padding: EdgeInsets.all(size.width * 0.035),
                     decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          spreadRadius: 2, // Kitna area cover kare shadow
                          blurRadius: 8, // Shadow ka smoothness
                          offset: Offset(0, 0), // 0,0 means har side se equal shadow
                        ),
                      ],
                    ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.teal, size: size.width * 0.06),
                          SizedBox(width: size.width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ADDRESS ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.03,
                                      color: Colors.grey,
                                    )),
                                SizedBox(height: size.height * 0.005),
                                Text(
                                  addresses[index],
                                  style: TextStyle(
                                    fontSize: size.width * 0.036,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(size.height * 0.055),
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Go Back",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    ElevatedButton(
                      onPressed: () {
                        // Add address logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size.fromHeight(size.height * 0.055),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Add Address",
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
