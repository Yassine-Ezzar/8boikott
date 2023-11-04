import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.purple,
        fontFamily: 'Roboto',
      ),
      home: BarcodeScannerApp(),
    );
  }
}

class BarcodeScannerApp extends StatefulWidget {
  @override
  _BarcodeScannerAppState createState() => _BarcodeScannerAppState();
}

class _BarcodeScannerAppState extends State<BarcodeScannerApp> {
  String result = "Appuyez sur le bouton pour scanner un code-barre.";

  Future scanBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Annuler", false, ScanMode.BARCODE);

    if (barcode == "619") {
      setState(() {
        result = "Boycott";
        textColor = Colors.red;
      });
    } else {
      setState(() {
        result = "OK";
        textColor = Colors.green;
      });
    }
    _navigateToResultScreen();
  }

  Color textColor = Colors.black;

  void _navigateToResultScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            ResultScreen(result: result, textColor: textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.qr_code_scanner,
              size: 120.0,
              color: Colors.blue,
            ),
            SizedBox(height: 40),
            Text(
              result,
              style: TextStyle(
                fontSize: 24.0,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text("Scanner un code-barre"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String result;
  final Color textColor;

  ResultScreen({required this.result, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Résultat du Scanner',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle, // Use a checkmark icon for success
              size: 120.0,
              color: textColor,
            ),
            SizedBox(height: 40),
            Text(
              result,
              style: TextStyle(
                fontSize: 24.0,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Return to the scanning screen
              },
              child: Text("Retour"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
