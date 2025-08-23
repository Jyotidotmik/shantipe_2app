import 'package:flutter/material.dart';

import '../../Utils/Custom_AppBar.dart';
import 'Models/APes_Service_model.dart';
import 'Widget/Service_Card.dart';


class AepsHomeScreen extends StatelessWidget {
  AepsHomeScreen({super.key});

  final List<AepsServiceModel> services = [
    AepsServiceModel(name: 'Balance Enquiry', route: 'balance'),
    AepsServiceModel(name: 'Ministatement', route: 'ministatement'),
    AepsServiceModel(name: 'Cash Withdrawal', route: 'withdrawal'),
    AepsServiceModel(name: 'Cash Deposit', route: 'deposit'),
  ];

  void _navigate(BuildContext context, String route) {
    switch (route) {
      case 'balance':
        //Navigator.push(context, MaterialPageRoute(builder: (_) => const BalanceEnquiryScreen()));
        break;
      case 'ministatement':
        //Navigator.push(context, MaterialPageRoute(builder: (_) => const MinistatementScreen()));
        break;
      case 'withdrawal':
        //Navigator.push(context, MaterialPageRoute(builder: (_) => const CashWithdrawalScreen()));
        break;
      case 'deposit':
        //Navigator.push(context, MaterialPageRoute(builder: (_) => const CashDepositScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "AePS all services"),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCard(
            title: service.name,
            onTap: () => _navigate(context, service.route),
          );
        },
      ),
    );
  }
}
