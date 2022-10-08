import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Heyy there,";
  Future _scanQR() async {
    try {
      // String qrResult = await BarcodeScanner.scan() as String;
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
    // Uri url = result as Uri;
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
      appBar: AppBar(title: const Text("QR Scanner")),
      body: SafeArea(
        child: Center(
            // child: Text(result),
            child: TextButton(
          onPressed: _launchedurl,
          child: Text(result),
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scanQR,
        icon: const Icon(Icons.camera_alt),
        label: const Text("Scan Here"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
