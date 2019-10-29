import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CekPart extends StatefulWidget {
  @override
  _CekPartState createState() => _CekPartState();
}

class _CekPartState extends State<CekPart> {
  QRViewController _controller;

  void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
    controller.scannedDataStream.listen((data) {
      controller.pauseCamera();
      print(data);
      controller.resumeCamera();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Parts'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tidak bisa scan?',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Coba masukkan kode',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                RaisedButton(
                  textColor: Colors.red,
                  child: Text('KODE'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          QRView(
            key: GlobalKey(debugLabel: 'QR'),
            onQRViewCreated: _onQRViewCreated,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.flip),
                color: Colors.red,
                onPressed: (){
                  _controller.flipCamera();
                },
              ),
              IconButton(
                icon: Icon(Icons.flash_on),
                color: Colors.red,
                onPressed: (){
                  _controller.toggleFlash();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
