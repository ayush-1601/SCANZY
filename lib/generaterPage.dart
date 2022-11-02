import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
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
        centerTitle: true,
        title: Text(
          "QR Code Generator",
          style: GoogleFonts.lato(
            fontSize: 25,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        backgroundColor: Color(0xfff289ac9),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfffdff3f8),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    alignment: Alignment.center,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        color: Color(0xfffdff3f8),
                        border: Border.all(color: Color(0xfffdff3f8), width: 5),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xfff289ac9),
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 20,
                            spreadRadius: 5.0,
                          )
                        ]),
                    height: 300, width: 300,
                    // padding: EdgeInsets.all(8.0),
                    child: QrImage(
                      data: qrData,
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "Generate new QR code",
                  style: GoogleFonts.lato(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  cursorColor: Color(0xfff289ac9),
                  controller: qrdataFeed,
                  decoration: InputDecoration(
                    label: Text(
                      "Input your link/text here",
                      style: GoogleFonts.lato(color: Color(0xfff289ac9)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        // height: 30,
                        child: FloatingActionButton.extended(
                          backgroundColor: Color(0xfff289ac9),
                          shape: StadiumBorder(),
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
                          label: Text(
                            "Generate QR".toUpperCase(),
                            style: GoogleFonts.lato(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        // height: 30,
                        width: 200,
                        child: FloatingActionButton.extended(
                          backgroundColor: Color(0xfff289ac9),
                          shape: const StadiumBorder(),
                          onPressed: _shareqr,
                          label: Text(
                            "Share".toUpperCase(),
                            style: GoogleFonts.lato(
                              fontSize: 18,
                            ),
                          ),
                        ),
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
