import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';

import 'Login_Screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;
  // ignore: unused_field
  late Animation<double> _fadeAnimation;

  final List<String> _imagePaths = [
    'lib/assets/images/shanti.png',
    'lib/assets/images/dotmik.png',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _startAnimationLoop();
    // _checkNavigation();
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

    _controller.forward(); // Start initial animation
  }

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool showLastName = false;
  bool showPhone = false;
  bool showEmail = false;
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Image.asset(
                      _imagePaths[_currentIndex],
                      height: 230,
                      width: 230,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              const Text(
                "Create an Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // First Name
              TextField(
                controller: _firstName,
                decoration: _inputDecoration("First Name", Icons.person),
                onChanged: (val) {
                  if (val.trim().isNotEmpty && !showLastName) {
                    setState(() => showLastName = true);
                  }
                },
              ),
              const SizedBox(height: 16),
              // Last Name
              if (showLastName)
                Column(
                  children: [
                    TextField(
                      controller: _lastName,
                      decoration: _inputDecoration("Last Name", Icons.person),
                      onChanged: (val) {
                        if (val.trim().isNotEmpty && !showPhone) {
                          setState(() => showPhone = true);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Phone Number
              if (showPhone)
                Column(
                  children: [
                    TextField(
                      controller: _phone,
                      decoration: _inputDecoration("Phone Number", Icons.phone),
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {
                        if (val.trim().isNotEmpty && !showEmail) {
                          setState(() => showEmail = true);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Email
              if (showEmail)
                Column(
                  children: [
                    TextField(
                      controller: _email,
                      decoration: _inputDecoration(
                        "Email",
                        Icons.email_outlined,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        if (val.trim().isNotEmpty && !showPassword) {
                          setState(() => showPassword = true);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Password
              if (showPassword)
                Column(
                  children: [
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: _inputDecoration("Password", Icons.lock),
                      onChanged: (val) {
                        if (val.trim().isNotEmpty && !showConfirmPassword) {
                          setState(() => showConfirmPassword = true);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Confirm Password + Button
              if (showConfirmPassword)
                Column(
                  children: [
                    TextField(
                      controller: _confirmPassword,
                      obscureText: true,
                      decoration: _inputDecoration(
                        "Confirm Password",
                        Icons.lock_outline,
                      ),
                    ),
                    const SizedBox(height: 35),
                    _actionButton(
                      "Register Account",
                      onPressed: () => Get.toNamed('/login'),
                    ),
                  ],
                ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/login'),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xff0080FF),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
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

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Color(0xff0080FF)),
      hintText: hint,
      labelText: hint,
      filled: true,
      // ignore: deprecated_member_use
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
