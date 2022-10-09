import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/homePage.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  String qrData = "https://github.com/ayush-1601";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code generator'),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QrImage(data: qrData,padding: EdgeInsets.all(40.0),),
                const Text(
                  "New QR Link Generator",
                ),
                TextField(
                  controller: qrdataFeed,
                  decoration: const InputDecoration(
                    label: Text("input ur link here"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
                  child: FloatingActionButton.extended(
                    // paddding: const EdgeInsets.all(15.0),
                    onPressed: () {
                      if (qrdataFeed.text.isEmpty) {
                        setState(() {
                          qrData = "";
                        });
                      } else {
                        setState(() {
                          qrData = qrdataFeed.text;
                        });
                      }
                    },
                    label: const Text("Generate QR"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();
}
