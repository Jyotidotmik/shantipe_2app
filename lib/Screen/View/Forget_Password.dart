import 'dart:async';
import 'package:flutter/material.dart';

import 'Login_Screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<String> _imagePaths = [
    'lib/assets/images/shanti.png',
    'lib/assets/images/dotmik.png',
  ];

  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
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
                    const SizedBox(height: 40),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Image.asset(
                      _imagePaths[_currentIndex],
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    "Forget Password!",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your email address and we’ll send you a link to reset your password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                 TextField(
                controller: _emailController,
                decoration: _inputDecoration("Email", Icons.email),
                // onChanged: (val) {
                //   if (val.trim().isNotEmpty && !showPassword) {
                //     setState(() => showPassword = true);
                //   }
                // },
              ),
                  const SizedBox(height: 40),
                  _actionButton("Send Reset Link", onPressed: () {
                    final email = _emailController.text.trim();
                    if (email.isEmpty || !email.contains("@")) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a valid email.")),
                      );
                    } else {
                      print("Reset link sent to: $email");
                    }
                  }),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Color(0xff0080FF)),
      hintText: hint,
      labelText: hint,
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black, 
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.black, 
        ),
      ),
      hintStyle: const TextStyle(color: Colors.black),
    );
  }

  Widget _actionButton(String label, {required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff0080FF),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()));},
      child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
    ));
  }
}
