import 'package:flutter/material.dart';
import 'package:shantipe_2app/Screen/KYC_Form/KYC_Form_Screen.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KycPendingScreen extends StatefulWidget {
  const KycPendingScreen({super.key});

  @override
  _KycPendingScreenState createState() => _KycPendingScreenState();
}

class _KycPendingScreenState extends State<KycPendingScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isButtonVisible = true;
  void initState() {
    super.initState();
    //startKycStatusCheck(context); //  Auto Check Start करो
  }

  void _scrollToBottomAndFetch() async {
    // Animate scroll to the bottom
    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );

    // Call the fetchDashboard method
    // ApiService apiService = ApiService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? authKey = prefs.getString('Authkey');

    if (token != null && authKey != null) {
      //apiService.fetchDashboard(context, token, authKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "KYC Information",
        onBackPress: () {
          print("Custom back pressed");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => KycFormScreen(
                        initialStep: 1,
                      )));
        },
      ),
      body: Stack(
        children: [
          // The content of the screen
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  // Display the image
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.3, 
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('lib/assets/intro/cuate.png'), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'KYC Pending',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your KYC process is still pending. Please complete it to proceed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ),
          // Animated Scroll Button
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom: _isButtonVisible ? 50 : -20, 
            left: MediaQuery.of(context).size.width / 2 - 30, 
            child: FloatingActionButton(
              onPressed: () {
                _scrollToBottomAndFetch();
                setState(() {
                  _isButtonVisible = false;
                });
                // Now Navigate to KYC Form
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KycFormScreen(initialStep: 1)),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const KycFormScreen(initialStep: 2)),
                );
              },
              child: Icon(Icons.arrow_downward),
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
