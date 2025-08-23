// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shantipe_2app/Screen/BottomBar/Business_Screen.dart';
import 'package:shantipe_2app/Screen/BottomBar/Home_Screen.dart';
import 'package:shantipe_2app/Screen/BottomBar/Profile_Scrteen.dart';

import '../Reports/Reports_Screen.dart';
class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({super.key});
  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  // ignore: unused_field
  TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? data;

  bool _isSearching = false;
  bool isLoading = true;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseData = prefs.getString('responseData');
    if (responseData != null) {
      setState(() {
        data = json.decode(responseData);
      });
    } else {
      setState(() {
        data = {};
      });
    }
  }

  Future<void> _refreshData() async {
    await _loadData();
  }

  int _page = 0;
  List<Widget> get screens => [
        RefreshIndicator(onRefresh: _refreshData, child: HomeScreen()),
        RefreshIndicator(onRefresh: _refreshData, child: ReportScreen()),
        RefreshIndicator(onRefresh: _refreshData, child: BusinessScreen()),
        RefreshIndicator(onRefresh: _refreshData, child: ProfileScreen()),
      ];
// PreferredSizeWidget getAppBar() {
//   switch (_page) {
//     case 0:
//       return AppBar(
//         backgroundColor: Colors.white,
//         elevation: 4,
//         centerTitle: true,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 15),
//           child: Image.asset(
//             'lib/assets/images/shanti.png',
//             height: 40, // Adjust as needed
//             fit: BoxFit.contain,
//           ),
//         ),
//       );
//     case 1:
//       return CustomAppBar(
//         titleText: "Reports",
//         onBackPress: () => _resetToHome(),
//       );
//     case 2:
//       return CustomAppBar(
//         titleText: "Business",
//         onBackPress: () => _resetToHome(),
//       );
//     case 3:
//       return CustomAppBar(
//         titleText: "Profile",
//         onBackPress: () => _resetToHome(),
//       );
//     default:
//       return AppBar();
//   }
// }


  // ignore: unused_element
  void _resetToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeBottomNavBar()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? shouldClose = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you really want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );

        if (shouldClose == true) {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
       //appBar: getAppBar(),
     appBar: AppBar(
  elevation: 0,
  automaticallyImplyLeading: false,
  centerTitle: true,
 backgroundColor: const Color(0xffFFFFFF),
  title: SizedBox(
    child: Image.asset(
      'lib/assets/images/logs.png', 
      height: 250,width:250,
      fit: BoxFit.contain,
    ),
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xffFFFFFF),
          Color(0xffFFFFFF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
),
        body: _isConnected
            ? Center(child: _isSearching ? Container() : screens[_page])
            : const Text('No Internet Connection'),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed('/qr_scanner'),
          backgroundColor: const  Color(0xff0080FF),
          foregroundColor: Colors.white,
          tooltip: 'QR Code',
          shape: const CircleBorder(),
          child: const Icon(Icons.qr_code, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, 'Home', 0),
              const SizedBox(width: 35),
              _buildNavItem(Icons.swap_horiz, 'Reports', 1),
              const SizedBox(width: 80),
              _buildNavItem(Icons.insert_chart, 'Business', 2),
              const SizedBox(width: 25),
              _buildNavItem(Icons.people, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _page = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.grey),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
