import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScannerScreen extends StatefulWidget {
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with TickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();
  final ImagePicker _picker = ImagePicker();
  
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  bool _isScanning = true;
  // ignore: unused_field
  String? _scannedData;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(capture) {
    if (!_isScanning) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      setState(() {
        _isScanning = false;
        _scannedData = barcodes.first.rawValue;
      });
      
      _showResultDialog(barcodes.first.rawValue ?? '');
    }
  }

  void _showResultDialog(String data) {
    bool isUPI = data.toLowerCase().contains('upi://pay');
    bool isURL = data.startsWith('http://') || data.startsWith('https://');
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                isUPI ? Icons.payment : Icons.qr_code,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                isUPI ? 'UPI Payment' : 'QR Code Scanned',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Container(
            constraints: BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isUPI) ...[
                    _buildUPIInfo(data),
                  ] else ...[
                    Text(
                      'Scanned Data:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            if (isUPI) ...[
              TextButton(
                onPressed: () => _copyToClipboard(data),
                child: Text('Copy'),
              ),
              ElevatedButton(
                onPressed: () => _launchUPI(data),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Pay Now'),
              ),
            ] else if (isURL) ...[
              TextButton(
                onPressed: () => _copyToClipboard(data),
                child: Text('Copy'),
              ),
              ElevatedButton(
                onPressed: () => _launchURL(data),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Open Link'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () => _copyToClipboard(data),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Copy Text'),
              ),
            ],
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isScanning = true;
                  _scannedData = null;
                });
              },
              child: Text('Scan Again'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUPIInfo(String upiData) {
    Map<String, String> upiParams = _parseUPIData(upiData);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (upiParams['pn'] != null) ...[
          _buildInfoRow('Name', upiParams['pn']!),
          SizedBox(height: 8),
        ],
        if (upiParams['pa'] != null) ...[
          _buildInfoRow('UPI ID', upiParams['pa']!),
          SizedBox(height: 8),
        ],
        if (upiParams['am'] != null) ...[
          _buildInfoRow('Amount', '₹${upiParams['am']}'),
          SizedBox(height: 8),
        ],
        if (upiParams['tn'] != null) ...[
          _buildInfoRow('Note', upiParams['tn']!),
          SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Map<String, String> _parseUPIData(String upiData) {
    Map<String, String> params = {};
    Uri uri = Uri.parse(upiData);
    params.addAll(uri.queryParameters);
    return params;
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied to clipboard!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _launchUPI(String upiData) async {
    if (await canLaunchUrl(Uri.parse(upiData))) {
      await launchUrl(Uri.parse(upiData));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No UPI app found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch URL'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // For gallery QR scanning, you would need additional QR decoding library
      // This is a placeholder for the functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gallery QR scanning feature coming soon!'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _toggleFlash() {
    cameraController.toggleTorch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera View
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
          ),
          
          // Overlay with scanning frame
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: Stack(
              children: [
                // Create hole in overlay
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CustomPaint(
                      painter: ScannerOverlayPainter(),
                    ),
                  ),
                ),
                
                // Animated scanning line
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            Positioned(
                              top: _animation.value * 220,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 3,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.red,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Top bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.white, size: 25),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _toggleFlash,
                      icon: Icon(Icons.flash_on, color: Colors.white, size: 25),
                    ),
                    IconButton(
                      onPressed: () => Get.toNamed('/qr_code'),
                      icon: Icon(Icons.qr_code_scanner, color: Colors.white, size: 25),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bottom section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Upload from gallery button
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      onPressed: _pickImageFromGallery,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.image, size: 20),
                          SizedBox(width: 8),
                          Text('Upload from gallery'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Bottom text
                  Text(
                    'Scan any QR code to pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Google Pay • PhonePe • PayTM • UPI',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    const double cornerLength = 25.0;
    
    // Top-left corner
    canvas.drawLine(Offset(0, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerLength), paint);
    
    // Top-right corner
    canvas.drawLine(Offset(size.width - cornerLength, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), paint);
    
    // Bottom-left corner
    canvas.drawLine(Offset(0, size.height - cornerLength), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(cornerLength, size.height), paint);
    
    // Bottom-right corner
    canvas.drawLine(Offset(size.width - cornerLength, size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - cornerLength), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}