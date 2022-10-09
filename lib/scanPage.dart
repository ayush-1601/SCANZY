import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String result = "hey....";
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
      body: Container(
        color: Colors.white60,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // child: Text(result),
            children: [
              Image.asset(
                'asset/images/img4.jpg',
              ),
              TextButton(
                onPressed: _launchedurl,
                child: Text("Result :" + result),
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scanQR,
        icon: const Icon(Icons.camera_alt),
        label: Text("Scan Here"),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),

      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
