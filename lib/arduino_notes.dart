import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ArduinoNotes extends StatefulWidget {
  const ArduinoNotes({super.key});

  @override
  _ArduinoNotesState createState() => _ArduinoNotesState();
}

class _ArduinoNotesState extends State<ArduinoNotes> {
  late List<Map<String, String>> pdfFiles; // List containing paths and custom names

  @override
  void initState() {
    super.initState();
    // Initialize with actual PDF paths and custom names
    pdfFiles = [
      {'path': 'lib/ArduinoNotes/what is arduino.pdf', 'name': 'What is Arduino'},
      {'path': 'lib/ArduinoNotes/arduino_components.pdf', 'name': 'Arduino Components'},
      {'path': 'lib/ArduinoNotes/arduino_input.pdf', 'name': 'Arduino Input'},
      {'path': 'lib/ArduinoNotes/arduino_output.pdf', 'name': 'Arduino Output'},
      {'path': 'lib/ArduinoNotes/arduinosyn.pdf', 'name': 'Arduino cheat sheets'},
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
          "A R D U I N O   L E S S O N S",
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
        title: const Text('A R D U I N O  L E S S O N S'),
        backgroundColor: Colors.pink[50], // Set the app bar color to pink
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}