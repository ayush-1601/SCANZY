import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String result = "Wann'a Scan Something?";
  Future _scanQR() async {
    try {
      ScanResult qrScanResult = await BarcodeScanner.scan();
      String qrResult = qrScanResult.rawContent;

      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "pressed back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Error $ex";
      });
    }
  }

  Future _launchedurl() async {
    var url = Uri.parse(result);
    if (await canLaunchUrl(url)) {
      await launchUrl(url,
          webViewConfiguration: const WebViewConfiguration(
              enableJavaScript: true, enableDomStorage: true),
          mode: LaunchMode.externalApplication);
    } else {
      Text(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "QR Scanner",
          style: GoogleFonts.lato(
            fontSize: 25,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        backgroundColor: const Color(0xfff289ac9),
      ),
      body: Container(
        color: const Color(0xfffdff3f8),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'asset/images/img2.jpg',
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xfff289ac9)),
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xfff289ac9),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16.0)),
                  onPressed: _launchedurl,
                  child: Text(
                    result,
                    style: GoogleFonts.lato(fontSize: 15),
                  ),
                ),
                height: 50,
                width: 20,
                margin: const EdgeInsets.all(50),
              )
            ]),
      ),
      floatingActionButton: SizedBox(
        child: FloatingActionButton.extended(
          onPressed: _scanQR,
          icon: const Icon(Icons.camera_alt),
          label: Text(
            "Scan Here".toUpperCase(),
            style: GoogleFonts.lato(),
          ),
          shape: const StadiumBorder(),
          backgroundColor: const Color(0xfff289ac9),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
