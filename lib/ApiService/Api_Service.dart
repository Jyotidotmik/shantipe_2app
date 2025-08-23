import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shantipe_2app/Screen/BottomBar/BottomNavigationBar.dart';
import 'package:shantipe_2app/Screen/KYC_Form/KYC_Form_Screen.dart';
import 'package:shantipe_2app/Screen/KYC_Form/Pending_Screen.dart';
import 'package:shantipe_2app/Screen/View/Login_Screen.dart';
import 'package:shantipe_2app/Screen/View/OTP_Verification.dart';
import 'package:shantipe_2app/Utils/Helper.dart';
import 'package:shantipe_2app/Utils/Notifies.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'https://b2b.shantipe.com/api/android';

  String _encrypt(String data) {
    final key = encrypt.Key.fromUtf8('934886cad106412a1e7be7d0965e3039');
    final iv = encrypt.IV.fromUtf8('DOTMIKSOFTWAREMK');

    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64;
  }

  Future<void> signUp(String firstName, String lastName, String email, String phone, String password) async {
    final url = Uri.parse('$baseUrl/authentication/signup');
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
    });

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      // ignore: unused_local_variable
      final data = jsonDecode(responseBody);
    } else {
      // ignore: unused_local_variable
      final responseBody = await response.stream.bytesToString();
    }
  }

//---------------------------logIn API Intergration--------------------------------
  Future<void> logIn(String email, String password, BuildContext context) async {
    try {
      final url = Uri.parse('$baseUrl/authentication/login');
      var request = http.MultipartRequest('POST', url);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Helper helper = Helper();
      String androidId = await helper.getAndroidId();
      String androidName = await helper.getAndroidName();
      Map<String, double> location = {};
      double latitude = location['latitude'] ?? 0.0;
      double longitude = location['longitude'] ?? 0.0;
      request.fields.addAll({
        'email': email,
        'password': password,
        'device_token': androidId,
        'device_name': androidName,
        'lat': latitude.toString(),
        'log': longitude.toString(),
      });

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final data = jsonDecode(responseBody);
      debugPrint("Login Response: $data");

      // Handle ERROR status with better error messages
      if (data['status'] == 'ERROR') {
        String errorMessage = data['message'] ?? 'Login failed';

        // Handle database constraint error
        if (errorMessage.contains('Integrity constraint violation') || errorMessage.contains('Column \'log\' cannot be null')) {
          errorMessage = 'Server maintenance in progress. Please try again later.';
        }

        throw Exception(errorMessage);
      }

      if (data['status'] == 'SUCCESS') {
        // Server response says OTP is needed
        final is2FAEnabled = data['activity']?.toString().toLowerCase() == 'authentication';
        await prefs.setBool('tfa_enabled', is2FAEnabled);

        if (is2FAEnabled) {
          final otpKey = data['key'] ?? '';
          if (otpKey.isEmpty) throw Exception('OTP key missing');

          await prefs.setString('keySignIn', otpKey);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => OtpVerificationScreen()),
            (Route<dynamic> route) => false,
          );
        } else {
          // Go to Dashboard directly
          final authData = data['data']?['authentication'];
          if (authData == null) throw Exception('Authentication data missing');

          final token = authData['token']?.toString() ?? '';
          final authKey = authData['key']?.toString() ?? '';

          if (token.isEmpty || authKey.isEmpty) {
            throw Exception('Authentication tokens missing');
          }

          await prefs.setString('token', _encrypt(token));
          await prefs.setString('Authkey', _encrypt(authKey));
          await prefs.remove('keySignIn');

          await fetchDashboard(context);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeBottomNavBar()),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        throw Exception(data['message'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint("Login Error: $e");

      // Clean error message display
      String displayMessage = e.toString().replaceAll('Exception: ', '');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(displayMessage),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

//--------------------------- TwoFactorStatus API Integration--------------------------------
  Future<Map<String, dynamic>> updateTwoFactorStatus(bool enable) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final authKey = prefs.getString('Authkey');

      if (token == null || authKey == null) {
        throw Exception('Authentication credentials missing');
      }

      final url = Uri.parse('$baseUrl/account-setting/updateTwoFactor').replace(queryParameters: {'tfa': enable ? '1' : '0'});

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': token,
          'key': authKey,
        },
      ).timeout(const Duration(seconds: 30));

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 'SUCCESS') {
        // Update local storage with new 2FA status
        await prefs.setBool('tfa_enabled', enable);
        await prefs.setString('tfa_status', enable ? '1' : '0');

        // Clear OTP-related data when disabling 2FA
        if (!enable) {
          await prefs.remove('keySignIn');
        }

        return {
          'success': true,
          'message': enable ? "2FA enabled successfully. You'll need OTP verification on next login." : "2FA disabled successfully. Direct login enabled.",
          'isEnabled': enable,
        };
      } else {
        throw Exception(data['message'] ?? "Failed to update 2FA status");
      }
    } catch (e) {
      debugPrint("2FA Update Error: $e");

      // Return error with current status
      final currentStatus = await check2FAStatus();
      return {
        'success': false,
        'message': "Failed to update 2FA: ${e.toString().replaceAll('Exception: ', '')}",
        'isEnabled': currentStatus,
      };
    }
  }

  Future<bool> check2FAStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('tfa_enabled') ?? false;
  }

//-----------------------logInOtp verifyLogin API Integration----------------------
  Future<void> logInOtp(String otpCode, BuildContext context) async {
    final url = Uri.parse('$baseUrl/authentication/verifyLogin');
    var request = http.MultipartRequest('POST', url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Helper helper = Helper();
    String androidId = await helper.getAndroidId();
    String androidName = await helper.getAndroidName();

    // Get location with proper error handling
    Map<String, double> location = {};
    try {
      location = await helper.getCurrentLocation(context);
    } catch (e) {
      print("Location error: $e");
      // Provide default values if location fails
      location = {'latitude': 0.0, 'longitude': 0.0};
    }

    // Fix: Use 'keySignIn' instead of 'key'
    String? key = prefs.getString('keySignIn');

    // Debug the key value
    print('Key from SharedPreferences: $key');

    // Check if key is null or empty
    if (key == null || key.isEmpty) {
      print('Error: Key is null or empty');
      NotifierUtils.showSnackBar(context, 'Session expired. Please login again.', isError: true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      return;
    }
    // Ensure location values are not null
    double latitude = location['latitude'] ?? 0.0;
    double longitude = location['longitude'] ?? 0.0;

    request.fields.addAll({
      'code': otpCode,
      'lat': latitude.toString(),
      'log': longitude.toString(),
      'key': key, // Remove string interpolation
      'device_token': androidId,
      'device_name': androidName,
    });

    // Debug all request fields
    print('Request fields: ${request.fields}');

    try {
      http.StreamedResponse response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (responseBody.isEmpty) {
        NotifierUtils.showSnackBar(context, 'Empty response from server', isError: true);
        return;
      }

      final data = jsonDecode(responseBody);
      print("Response data: $data");

      if (data['status'] == 'SUCCESS') {
        print("Login OTP verification successful");

        // Update the key with new one from server if provided
        if (data['key'] != null && data['key'].toString().isNotEmpty) {
          await prefs.setString('key', data['key']);
        }

        await prefs.setBool('logout', data['logout'] ?? false);

        String token = data['data']['authentication']['token'] ?? '';
        String authKey = data['data']['authentication']['key'] ?? '';

        // Ensure token and authKey are not null before encryption
        if (token.isNotEmpty && authKey.isNotEmpty) {
          String encryptedToken = _encrypt(token);
          String encryptedAuthKey = _encrypt(authKey);

          await prefs.setString('token', encryptedToken);
          await prefs.setString('Authkey', encryptedAuthKey);

          // Clean up the temporary keySignIn
          await prefs.remove('keySignIn');

          String? Token = prefs.getString('token');
          String? AuthKey = prefs.getString('Authkey');

          print('Token: $Token');
          print('AuthKey: $AuthKey');

          await fetchDashboard(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeBottomNavBar()),
          );
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          NotifierUtils.showSnackBar(context, 'Invalid response data', isError: true);
        }
      } else {
        // Handle specific error cases
        String errorMessage = data['message'] ?? 'Unknown error occurred';

        if (errorMessage.toLowerCase().contains('invalid') || errorMessage.toLowerCase().contains('expired')) {
          // Clear invalid keys and redirect to login
          await prefs.remove('key');
          await prefs.remove('keySignIn');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          NotifierUtils.showSnackBar(context, 'Session expired. Please login again.', isError: true);
        } else {
          NotifierUtils.showSnackBar(context, 'Login failed: $errorMessage', isError: true);
        }
      }
    } catch (e) {
      print('Exception in logInOtp: $e');
      NotifierUtils.showSnackBar(context, 'An error occurred: ${e.toString()}', isError: true);
    }
  }

//------------------- ResendOtp Api Integration-------------------------------------
  Future<Map<String, dynamic>?> resendOtp() async {
    try {
      final url = Uri.parse('$baseUrl/authentication/resendOtp');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Fix: Use 'keySignIn' instead of 'key'
      String? key = prefs.getString('keySignIn');

      // Check if key exists
      if (key == null || key.isEmpty) {
        print('Error: No key found for resend OTP');
        return {'status': 'ERROR', 'message': 'Session expired. Please login again.'};
      }

      final body = {
        'key': key,
      };

      print('Resend OTP request body: $body');

      // Make POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse response body
        final responseData = json.decode(response.body);
        print('Resend OTP Success: $responseData');
        return responseData;
      } else {
        print('Resend OTP Error: ${response.statusCode}');
        print('Response: ${response.body}');
        return {'status': 'ERROR', 'message': 'Failed to resend OTP. Please try again.'};
      }
    } catch (e) {
      print('Resend OTP Exception: $e');
      return {'status': 'ERROR', 'message': 'Network error. Please check your connection.'};
    }
  }

  //--------------------Forget Password Api Integration-------------------------------
  Future<Map<String, dynamic>> forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'email': email.trim(),
      };
      final url = Uri.parse('$baseUrl/authentication/forgetPassword');
      final headers = {'Content-Type': 'application/json'};

      debugPrint('ForgotPassword Request Body: $body');

      final response = await http.post(url, headers: headers, body: jsonEncode(body));
      final data = jsonDecode(response.body);

      debugPrint('ForgotPassword Response: $data');

      if (response.statusCode == 200) {
        final status = data['status_code'];

        if (status == 'TXN' || status == 'SUCCESS') {
          return {'status': 'SUCCESS', 'message': data['message'] ?? 'OTP sent to email'};
        } else {
          return {'status': 'ERROR', 'message': data['message'] ?? 'Something went wrong'};
        }
      } else {
        return {'status': 'ERROR', 'message': data['message'] ?? 'Something went wrong'};
      }
    } catch (e) {
      debugPrint('ForgotPassword Error: $e');
      return {'status': 'ERROR', 'message': 'Something went wrong, please try again.'};
    }
  }

  Future<void> checkAuths(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? authKey = prefs.getString('Authkey');
    print("the tkeonweespg $token $authKey");
    // If either token or authKey is null, redirect to login screen
    if (token == null || authKey == null) {
      Navigator.pushReplacementNamed(context, '/loginScreen');
    }
  }

//------------------------DashBoard API------------------------------
 
  Future<void> fetchDashboard(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('$baseUrl/dashboard');

    try {
      String? token = prefs.getString('token');
      String? authKey = prefs.getString('Authkey');

      final response = await http.get(
        url,
        headers: {
          'token': token ?? "",
          'key': authKey ?? "",
        },
      ).timeout(const Duration(seconds: 30));

      final body = response.body;
      final data = json.decode(body);
      final status = data['status'];
      final message = data['message'] ?? 'Something went wrong';
      final activity = data['activity'] ?? '';

      // Clean activity string
      final cleanActivity = activity.toString().trim().toLowerCase();

      // Handle SUCCESS case (status code 200 and status SUCCESS)
      if (response.statusCode == 200 && status == "SUCCESS") {
        await prefs.setString('responseData', body);

        if (cleanActivity == "dashboard") {
          final dashboardData = data['data'];
          if (dashboardData is Map && dashboardData['service'] != null && dashboardData['insurance'] != null) {
            Get.offAll(() => const HomeBottomNavBar());
          } else {
            Get.snackbar(
              "Error",
              "Incomplete dashboard data",
              backgroundColor: Colors.orange,
              colorText: Colors.white,
            );
          }
        } else {
          // Handle other successful activities
          _navigateBasedOnActivity(cleanActivity, message);
        }
      }
      // Handle ERROR cases (status code != 200 OR status != SUCCESS)
      else {
        _navigateBasedOnActivity(cleanActivity, message);
      }
    } catch (e) {
      Get.snackbar(
        "Network Error",
        "Failed to connect to server: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAll(() => LoginScreen());
    }
  }

// Extracted navigation logic for better code organization
  void _navigateBasedOnActivity(String activity, String message) async {
    switch (activity) {
      case "kyc_form":
        Get.snackbar(
          "KYC Required",
          message,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() => const KycFormScreen(initialStep: 1));
        break;

      case "kyc_phase2":
        Get.snackbar(
          "KYC Phase 2 Required",
          message,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() => const KycFormScreen(initialStep: 2));
        break;

      case "pending":
      case "kyc_pending":
        Get.snackbar(
          "Approval Pending",
          message,
          backgroundColor: Colors.amber,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() => const KycPendingScreen());
        break;

      case "dashboard":
        Get.snackbar(
          "Access Denied",
          message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        break;

      case "error":
        Get.snackbar(
          "Error",
          message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() => LoginScreen());
        break;

      case "logout":
      case "unauthorized":
        Get.snackbar(
          "Session Expired",
          "Please login again",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        // Clear stored data
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        await prefs.remove('Authkey');
        await prefs.remove('responseData');

        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() => LoginScreen());
        break;

      default:
        // Handle unknown activities or fallback cases
        if (activity.contains('kyc') && activity.contains('form')) {
          Get.snackbar(
            "KYC Required",
            message,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
          await Future.delayed(const Duration(milliseconds: 200));
          Get.offAll(() => const KycFormScreen(initialStep: 1));
        } else {
          Get.snackbar(
            "Unknown Activity",
            "Activity: $activity - $message",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
          await Future.delayed(const Duration(milliseconds: 200));
          Get.offAll(() => LoginScreen());
        }
        break;
    }
  }

// KYC Phase 2 Check Function-------------------------------
  void checkKycPhaseTwo(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/user/checkKycStatus');
    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    final data = jsonDecode(response.body);

    if (data['status'] == 'SUCCESS') {
      String activity = data['activity'] ?? '';
      if (activity == 'kyc_phase2') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const KycFormScreen(initialStep: 2)),
        );
      }
    }
  }

  Future<void> checkAuth(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? authKey = prefs.getString('Authkey');
    print("the tkeonweespg $token $authKey");
    // If either token or authKey is null, redirect to login screen
    if (token == null || authKey == null) {
      Navigator.pushReplacementNamed(context, '/loginScreen');
    }
  }

////---------------------kycphaseOne--------------------------------------
  Future<Map<String, dynamic>> kycphaseOne(String email, String mobile, String account, String pan, String aadhar, String ifsc, BuildContext context) async {
    Helper helper = Helper();
    final url = Uri.parse('$baseUrl/kyc/verification/phaseOne');
    var request = http.MultipartRequest('POST', url);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? authKey = prefs.getString('Authkey');

    if (token != null && authKey != null) {
      request.headers['token'] = token;
      request.headers['key'] = authKey;
    }
    Map<String, double> location = await helper.getCurrentLocation(context);

    request.fields.addAll({
      'email': email,
      'mobile': mobile,
      'account': account,
      'pan': pan,
      'aadhaar': aadhar,
      'ifsc': ifsc,
      'lat': '${location['latitude']}',
      'log': '${location['longitude']}',
    });

    http.StreamedResponse response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody);
      String reference = data['reference'] ?? '';
      await prefs.setString('reference', reference);
      return data;
    } else {
      final data = jsonDecode(responseBody);
      return data; // Return the error response for further handling
    }
  }

////------------------------kycOtpverify------------------------
  Future kycOtpverify(
    String otp,
  ) async {
    // ignore: unused_local_variable
    Helper helper = Helper();
    final url = Uri.parse('$baseUrl/kyc/verification/verifyByOtp');
    var request = http.MultipartRequest('POST', url);

    // Add headers if token and auth key are available
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? authKey = prefs.getString('Authkey');
    //key mil rha h login ke time pr ..............
    String? reference = prefs.getString('reference');

    if (token != null && authKey != null) {
      request.headers['token'] = token;
      request.headers['key'] = authKey;
    }

    request.fields.addAll({
      'otp': otp,
      'key': '$reference',
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      print(data);
    } else {
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      print(data);
    }
  }

  ///-------------------------kycphaseTwo----------------------------------------
  Future kycphaseTwo(
    File? panCardImage,
    File? aadharFrontImage,
    File? aadharBackImage,
    File? shopFrontImage,
    File? shopBackImage,
    String fatherName,
    String shopName,
    String shopAddress,
  ) async {
    final url = Uri.parse('$baseUrl/kyc/verification/phaseTwo');
    var request = http.MultipartRequest('POST', url);

    // Add headers if token and auth key are available
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? authKey = prefs.getString('Authkey');
    // ignore: unused_local_variable
    String? errorMessage;

    if (token != null && authKey != null) {
      request.headers['token'] = token;
      request.headers['key'] = authKey;
    }
    //
    // Function to compress image
    Future<http.MultipartFile> compressImage(File imageFile, String fieldName) async {
      final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());
      if (image == null) {
        throw Exception('Unable to decode image');
      }

      // Compress the image to ensure it is under 2MB
      img.Image resizedImage = img.copyResize(image, width: 800); // Resize as needed
      List<int> compressedImage = img.encodeJpg(resizedImage, quality: 85); // Adjust quality if needed

      // Create a temporary file for the compressed image
      final tempFile = File('${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await tempFile.writeAsBytes(compressedImage);

      return http.MultipartFile.fromPath(fieldName, tempFile.path);
    }

    // Add image files to the request
    if (panCardImage != null) {
      request.files.add(await compressImage(panCardImage, 'pan_image'));
    }
    if (aadharFrontImage != null) {
      request.files.add(await compressImage(aadharFrontImage, 'aadhaar_front'));
    }
    if (aadharBackImage != null) {
      request.files.add(await compressImage(aadharBackImage, 'aadhaar_back'));
    }
    if (shopFrontImage != null) {
      request.files.add(await compressImage(shopFrontImage, 'outlet_outer'));
    }
    if (shopBackImage != null) {
      request.files.add(await compressImage(shopBackImage, 'outlet_inner'));
    }

    // Add text fields to the request
    request.fields.addAll({
      'father_name': fatherName,
      'outlet': shopName,
      'outlet_address': shopAddress,
    });

    // Send the request
    http.StreamedResponse response = await request.send();
    print("KYC Successful!");
    if (response.statusCode == 200) {
      print(" any detail Okay ");
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      return data;
    } else {
      final responseBody = await response.stream.bytesToString();
      final data = jsonDecode(responseBody);
      return data;
    }
  }
}
