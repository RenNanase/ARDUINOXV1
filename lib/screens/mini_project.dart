import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MiniProject extends StatefulWidget {
  const MiniProject({super.key});

  @override
  _MiniProjectState createState() => _MiniProjectState();
}

class _MiniProjectState extends State<MiniProject> {
  late List<Map<String, String>> pdfFiles; // List containing paths and custom names

  @override
  void initState() {
    super.initState();
    // Initialize with actual PDF paths and custom names
    pdfFiles = [
      {'path': 'lib/minip/minip1.pdf', 'name': 'Blink an LED with arduino in Tinkercad'},
      {'path': 'lib/minip/minip2.pdf', 'name': 'Ultrasonic distance sensor with Arduino in Tinkercad'},
    ];
  }

  void _filterPdfList(String query) {
    setState(() {
      pdfFiles = pdfFiles
          .where((pdf) => pdf['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink[100],
        title: const Text(
          "M I N I   P R O J E C T S",
        ),
      ),
      body: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.pink[50], // Set the PDF box color to light pink
        child: ListView.builder(
          itemCount: pdfFiles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                pdfFiles[index]['name']!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerPage(pdfPath: pdfFiles[index]['path']!),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewerPage({super.key, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('M I N I  P R O J E C T S'),
        backgroundColor: Colors.pink[50], // Set the app bar color to pink
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}