import 'package:flutter/material.dart';

class NotedScreen extends StatefulWidget {
  final String userName;
  final String userImage;

  const NotedScreen({
    super.key,
    required this.userName,
    required this.userImage,
  });

  @override
  State<NotedScreen> createState() => _NotedScreenState();
}

class _NotedScreenState extends State<NotedScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.userName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            SizedBox(height: h * 0.02),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.userImage),
            ),
            SizedBox(height: h * 0.01),
            TextField(
              controller: _amountController,
              style: const TextStyle(
                  fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "₹0",
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _noteController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "Add note",
                border: InputBorder.none,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: Size(w * 0.35, 50),
                  ),
                  onPressed: () {
                    // Simulate send API logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Payment Sent!")),
                    );
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: Size(w * 0.35, 50),
                  ),
                  onPressed: () {
                    // Simulate request API logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Request Sent!")),
                    );
                  },
                  child: const Text(
                    "Request",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }
}