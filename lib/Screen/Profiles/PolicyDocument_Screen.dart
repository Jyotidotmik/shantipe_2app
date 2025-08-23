import 'package:flutter/material.dart';
import 'package:shantipe_2app/Utils/Custom_AppBar.dart';

class PolicyDocumentsScreen extends StatelessWidget {
  const PolicyDocumentsScreen({super.key});

  final List<_PolicyItem> _items = const [
    _PolicyItem(title: "Terms and Conditions"),
    _PolicyItem(title: "Privacy Policy"),
    _PolicyItem(title: "Lending Privacy Policy"),
    _PolicyItem(title: "Grievance Redressal Policy"),
    _PolicyItem(title: "Lender Grievance Redressal Details"),
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
       appBar: CustomAppBar(
        titleText: 'Ploicy Documents',
     onBackPress: () {
       print(' Custom back press');
       Navigator.pop(context);
     },
     ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "General",
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: h * 0.015),

              // List of items
              Expanded(
                child: ListView.separated(
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => SizedBox(height: h * 0.015),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return _policyTile(context, w, h, item.title, onTap: () {
                      // handle tap (open page, webview, etc.)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.title} clicked')),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _policyTile(BuildContext context, double w, double h, String title, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.035, vertical: h * 0.02),
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
          children: [
            // blue info circle
            Container(
              width: w * 0.11,
              height: w * 0.11,
              decoration: BoxDecoration(
                color: const Color(0xFF2B6BFF).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.info,
                  color: const Color(0xFF2B6BFF),
                  size: w * 0.06,
                ),
              ),
            ),
            SizedBox(width: w * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: w * 0.042,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: w * 0.04,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}

class _PolicyItem {
  final String title;
  const _PolicyItem({required this.title});
}
