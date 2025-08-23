import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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
    _checkNavigation();
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

  Future<void> _checkNavigation() async {
    await Future.delayed(const Duration(seconds: 6)); // splash delay
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool hasShownIntro = prefs.getBool('hasShownIntro') ?? false;
      String? token = prefs.getString('token');
      String? authKey = prefs.getString('Authkey');

      if (!hasShownIntro) {
        Get.toNamed('/onboarding');
      } else if (token == null || authKey == null || token.isEmpty || authKey.isEmpty) {
        Get.toNamed('/login');
      } else {
        Get.toNamed('/home');
      }
    } catch (e) {
      Get.toNamed('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Image.asset(
            _imagePaths[_currentIndex],
            height: 300,
            width: 300,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
