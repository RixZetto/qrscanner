import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class QRCode {
  final String id;
  final String content;
  final DateTime? scannedAt;

  QRCode({required this.id, required this.content, required this.scannedAt});

  factory QRCode.fromJson(Map<String, dynamic> json) {
    return QRCode(
      id: json['id'] as String,
      content: json['content'] as String,
      scannedAt:
          json['scannedAt'] != null && json['scannedAt'].toString().isNotEmpty
              ? DateTime.parse(json['scannedAt'])
              : null,
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MethodChannel _channel = MethodChannel('com.rixstudio.qrcode');
  List<QRCode> qrCodes = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchQRCodes();
  }

  Future<void> fetchQRCodes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<dynamic>? result = await _channel.invokeMethod("fetchQRCodes");
      if (result == null) {
        return;
      }
      print("result $result");
      setState(() {
        qrCodes =
            result
                .map(
                  (e) => QRCode.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList();
      });
    } on PlatformException catch (e) {
      print("Failed to fetch QR codes: '${e.message}'.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('QR Code Scanner')),
        body:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : qrCodes.isEmpty
                ? Center(child: Text("Aún no has escaneado ningún código QR"))
                : ListView.builder(
                  itemCount: qrCodes.length,
                  itemBuilder: (context, index) {
                    final qr = qrCodes[index];
                    return ListTile(
                      title: Text(qr.content),
                      subtitle: Text(
                        qr.scannedAt != null
                            ? "Escaneado el: ${qr.scannedAt}"
                            : "Fecha desconocida",
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
