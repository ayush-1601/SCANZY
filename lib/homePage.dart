import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qr_scanner/generaterPage.dart';
import 'package:flutter_qr_scanner/scanPage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner & Generator"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 43, 160, 203),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'asset/images/img3.jpg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 80.0),
            button("scan", ScanPage()),
            const SizedBox(height: 20.0),
            button("generate", GeneratePage())
          ],
        ),
      ),
    );
  }

  Widget button(String text, Widget widget) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      style: ButtonStyle(
          shape: ButtonStyleButton.allOrNull(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)))),

      // shape: RoundedRectangleBorder(
      //     side: const BorderSide(color: Colors.black87, width: 5.0),
      //     borderRadius: BorderRadius.circular(20.0)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.amber, fontSize: 20),
      ),
    );
  }
}
