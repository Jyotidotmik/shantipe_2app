import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<String> _imagePaths = [
    'lib/assets/images/shanti.png',
    'lib/assets/images/dotmik.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _startAnimationLoop();
  }

  void _startAnimationLoop() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        _currentIndex = (_currentIndex + 1) % _imagePaths.length;
        _controller.reset();
        _controller.forward();
      });
    });
    _controller.forward(); 
  }

  // ignore: unused_field
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
    backgroundColor: const Color(0xffFFFFFF),
    body: Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    //const SizedBox(height: 50),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Image.asset(
                      _imagePaths[_currentIndex],
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
              //const SizedBox(height: 20),
                            PinCodeTextField(
                            controller: _otpController,
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 6,
                            obscureText: false,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(12),
                              fieldHeight: 40,
                              fieldWidth: 40,
                              
                              activeColor: Colors.blueAccent,
                              inactiveColor: Colors.blueAccent,
                              selectedColor: Colors.blue,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            cursorHeight: 10,
                            animationDuration: const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onChanged: (value) {},
                          ),
                          const SizedBox(height: 20),
                          Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Please send me again? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed('/signup'),
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(
                                color: Color(0xff0080FF),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0080FF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                },
                child: Text("Verify",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ))));
  }
}
