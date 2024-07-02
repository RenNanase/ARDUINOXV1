import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TinkercadNotes extends StatefulWidget {
  const TinkercadNotes({super.key});

  @override
  _TinkercadNotesState createState() => _TinkercadNotesState();
}

class _TinkercadNotesState extends State<TinkercadNotes> {
  late List<Map<String, String>> pdfFiles; // List containing paths and custom names

  @override
  void initState() {
    super.initState();
    // Initialize with actual PDF paths and custom names
    pdfFiles = [
      {'path': 'lib/TinkerNotes/intro_tinkercad.pdf', 'name': 'Introduction to Tinkercad'},
      {'path': 'lib/TinkerNotes/gsw_tinkercad.pdf', 'name': 'Getting started with Tinkercad'},
      {'path': 'lib/TinkerNotes/Tinkercad_circuit.pdf', 'name': 'Tinkercad Circuit'},
      {'path': 'lib/TinkerNotes/arduinoin_tinkercad.pdf', 'name': 'Arduino in Tinkercad'},

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
          'T I N K E R C A D   L E S S O N S',
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
        title: const Text('T I N K E R C A D   L E S S O N S'),
        centerTitle: true,
        backgroundColor: Colors.pink[100], // Set the app bar color to pink
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}