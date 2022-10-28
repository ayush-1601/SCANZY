import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/homePage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class GeneratePage extends StatefulWidget {
  const GeneratePage({super.key});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  GlobalKey globalKey = GlobalKey();
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
                RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 350, width: 350,
                    // padding: EdgeInsets.all(8.0),
                    child: QrImage(
                      data: qrData,
                      padding: EdgeInsets.all(40.0),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                const Text(
                  "New QR Link Generator", style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: qrdataFeed,
                  decoration: const InputDecoration(
                    label: Text("input ur link here"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
                  child: Column(
                    children: [
                      FloatingActionButton.extended(
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
                      const SizedBox(
                        height: 10.0,
                      ),
                      FloatingActionButton.extended(
                        onPressed: _shareqr,
                        label: const Text("Share"),
                      )
                    ],
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

  Future _shareqr() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final imageDev = await boundary.toImage();
      final bytes = await imageDev.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = bytes!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file1 = '${tempDir.path}/image.png';
      File(file1).writeAsBytesSync(pngBytes);

      // final channel = MethodChannel('channel:me.alfian.share/share');
      // channel.invokeMethod('shareFile', 'image.png');

      // ignore: deprecated_member_use
      await Share.shareFiles([file1],
          text: "Share the QR Code", subject: "link");
    } catch (e) {
      print(e.toString());
    }
  }
}
