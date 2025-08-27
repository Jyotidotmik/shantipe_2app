import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class DmtDashboard extends StatefulWidget {
  const DmtDashboard({super.key});

  @override
  State<DmtDashboard> createState() => _DmtDashboardState();
}

class _DmtDashboardState extends State<DmtDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(titleText: "",
      onBackPress: () {
        Navigator.pop(context);
      },),
    );
  }
}