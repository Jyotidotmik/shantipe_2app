import 'package:get/get.dart';
import 'package:shantipe_2app/Screen/Profiles/Aadhar_Verification/Aadhar_Screen.dart';
import 'package:shantipe_2app/Screen/Slider/Send_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/PolicyDocument_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/Bank_AccountScreen.dart';
import 'package:shantipe_2app/Screen/Profiles/BusinessDocument.dart';
import 'package:shantipe_2app/Screen/Profiles/Business_Details/BusinessScreen.dart';
import 'package:shantipe_2app/Screen/Profiles/DigitalVerification.dart';
import 'package:shantipe_2app/Screen/Profiles/FAQs_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/GST_DetailsScreen.dart';
import 'package:shantipe_2app/Screen/Profiles/My_Account/MyAccount_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/MyAddress_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/PanDetails_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/PhoneNumber_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/Refer&Earn_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/Setting_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/ShopPhotos_Screen.dart';
import 'package:shantipe_2app/Screen/Profiles/SupportScreen.dart';
import 'package:shantipe_2app/Screen/View/Forget_Password.dart';
import 'package:shantipe_2app/Screen/KYC_Form/KYC_Form_Screen.dart';
import 'package:shantipe_2app/Screen/KYC_Form/Pending_Screen.dart';
import 'package:shantipe_2app/Screen/View/Login_Screen.dart';
import 'package:shantipe_2app/Screen/View/Notification_Screen.dart';
import 'package:shantipe_2app/Screen/View/OTP_Verification.dart';
import 'package:shantipe_2app/Screen/View/Onboarding_Screen.dart';
import 'package:shantipe_2app/Screen/QR_Scanner/QR_CodeGenrator.dart';
import 'package:shantipe_2app/Screen/QR_Scanner/QR_Scanner.dart';
import 'package:shantipe_2app/Screen/View/SingUp_Screen.dart';
import 'package:shantipe_2app/Screen/View/Splash_Screen.dart';
import '../../Screen/APeS/AePS_Screen.dart';
import '../../Screen/Fund Transfer/Add_Beneficiary.dart';
import '../../Screen/Fund Transfer/FundLogin_Screen.dart';
import '../../Screen/Fund Transfer/FundTransfer_Screen.dart';
import '../../Screen/Fund Transfer/Register_Screen.dart';
import '../../Screen/Profiles/Invoices/Invoice_Screen.dart';
import '../../Screen/Reports/Reports_Screen.dart' show ReportScreen;
import '../../Screen/Slider/CDM/CDM_Card_Screen.dart';
import '../../Screen/Slider/Fund Request/FundRequest_Screen.dart';
import '../../Screen/Slider/Fund Request/Payment_Send.dart';
import '../../Screen/Slider/Noted_Screen.dart';
import '../../Screen/Slider/Receive_Screen.dart';
import '../../Screen/Slider/TransactionHistory.dart'
    show TransactionHistoryScreen;
import '../../Screen/Slider/Transfer_Screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignupScreen()),
    GetPage(name: '/forgot-password', page: () => ForgetPasswordScreen()),
    GetPage(name: '/otp_verification', page: () => OtpVerificationScreen()),
    //--------------------------QR Scanner Page-----------------------
    GetPage(name: '/qr_scanner', page: () => QRScannerScreen()),
    GetPage(name: '/qr_code', page: () => QrPaymentScreen()),
    //------------------KYC Form--------------------------------------
    GetPage(name: '/kyc_pending', page: () => KycPendingScreen()),
    GetPage(name: '/kyc_form', page: () => KycFormScreen(initialStep: 1)),
    //-----------------Profile Setting---------------------------------
    GetPage(name: '/my_account', page: () => ManageAccountScreen()),
    GetPage(name: '/Business', page: () => BusinessDetailsScreen()),
    GetPage(name: "/bank_account", page: () => BankAccountScreen()),
    GetPage(name: "/my_address", page: () => AddressDetailsScreen()),
    GetPage(name: "/phone_number", page: () => PhoneNumberScreen()),
    GetPage(name: "/pan_details", page: () => PanVerificationScreen()),
    GetPage(name: '/aadhar_details', page: () => AadhaarScreen()),
    GetPage(name: '/shop_details', page: () => ShopPhotosScreen()),
    GetPage(name: '/upload_document', page: () => DocumentUploadScreen()),
    GetPage(name: '/gst_details', page: () => GstDetailsscreen()),
    GetPage(name: '/digital_verification', page: () => DigitalVerificationScreen(),),
    GetPage(name: '/setting', page: () => SettingScreen()),
    GetPage(name: '/supports', page: () => SupportScreen()),
    GetPage(name: "/refer&earn", page: () => RewardsHubScreen()),
    GetPage(name: '/notification', page: () => NotificationScreen()),
    GetPage(name: '/faqs', page: () => HelpTopicsScreen()),
    GetPage(name: '/policy_documents', page: () => PolicyDocumentsScreen()),
    GetPage(name: '/invoice_screen', page: () => InvoiceScreen()),
    //-----------------------------------Slider Screen-----------------------------------
    GetPage(name: '/send_screen', page: () => SendScreen()),
    GetPage(
      name: '/payment_chat',
      page: () => NotedScreen(userName: '', userImage: ''),
    ),
    GetPage(name: '/Receive', page: () => ReceiveScreen()),
    GetPage(name: '/card_screen', page: () => AddNewCardScreen()),
    GetPage(name: "/transfer", page: () => TransferScreen()),
    GetPage(name: "/history", page: () => TransactionHistoryScreen()),
    GetPage(name: "/fund_request", page: () => BankCardDropdownScreen()),
    GetPage(
      name: '/payment_send',
      page:
          () => PaytmReceiptScreen(
            amount: 523,
            remark: '',
            amountInWords: '',
            toBank: '',
            fromBank: '',
            referenceId: '',
            dateTimeText: '',
            mode: '',
            pending: '',
          ),
    ),
    GetPage(name: '/reports', page: () => ReportScreen()),
    //----------------------------------Money Transfer-------------------------------------------
    GetPage(name: '/AePS_screen', page: () => AepsHomeScreen()),
    GetPage(name: '/Fund_Login', page: () => FundLoginScreen()),
    GetPage(name: '/FundTransfer_Screen', page: () => FundtransferScreen()),
    GetPage(name: '/Fund_Resister', page: () => fundTransferRegister(
      mobile: '', contactKeyEncoded: '', fromScreen: '',),),
      GetPage(name: '/Add_Beneficiary', page: () =>AddBeneficiary(contactKeyEncoded: '',)),
  ];
}
