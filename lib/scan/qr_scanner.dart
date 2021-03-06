import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({@required this.onScanCallback}) : assert(onScanCallback != null);

  final OnScanQrCodeCallback onScanCallback;

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController _controller;
  StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxSize = min(constraints.maxWidth, constraints.maxHeight);
      final scanAreaSize = maxSize * 0.7;
      return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(borderColor: Colors.red, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanAreaSize),
      );
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    _subscription = _controller.scannedDataStream.listen((scanData) {
      widget.onScanCallback(scanData.code);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller?.dispose();
    super.dispose();
  }
}

typedef OnScanQrCodeCallback = Function(String code);
