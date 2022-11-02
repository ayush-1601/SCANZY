import 'package:flutter/material.dart';
import 'package:flutter_qr_scanner/generaterPage.dart';
import 'package:flutter_qr_scanner/scanPage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xfffed883),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "QR Code",
              style: GoogleFonts.lato(
                fontSize: 70,
                color: Color(0xfff33495f),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "App",
              style: GoogleFonts.lato(
                fontSize: 70,
                color: Color(0xfff33495f),
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
              elevation: 0,
              margin: const EdgeInsets.all(8.0),
              child: Image.asset(
                'asset/images/img5.jpg',
                fit: BoxFit.cover,
                height: 350,
                width: 350,
              ),
            ),
            const SizedBox(
              height: 80.0,
              width: 20,
            ),
            button("Scan any QR".toUpperCase(), ScanPage()),
            const SizedBox(
              height: 20.0,
              width: 20,
            ),
            button("Generate QR Code".toUpperCase(), GeneratePage())
          ],
        ),
      ),
    );
  }

  Widget button(String text, Widget widget) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      label: Text(
        text,
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displaySmall,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
      backgroundColor: Color(0xffff82b59),
    );
  }
}
