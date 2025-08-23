import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shantipe_2app/Screen/View/Splash_Screen.dart';
import 'package:shantipe_2app/Utils/Routes/Routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize routes
  //await AppRoutes.initializeRoutes();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ShantiPe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      debugShowMaterialGrid: false,
      home: SplashScreen(),
       getPages: AppRoutes.routes,
    );
  }
}
