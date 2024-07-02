import 'package:flutter/material.dart';
import 'screens/basic_arduino.dart';
import 'screens/arduino_syntax.dart';
import 'screens/gettoknowtinkercad.dart';
import 'screens/arduinoio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Page',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Q U I Z'),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
      ),



      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    QuizCard('B A S I C    A R D U I N O', Color(0xFFF48FB1)),
                    QuizCardStacked(
                      'G E T  T O  K N O W',
                      'T I N K E R C A D',
                      Color(0xFF80CBC4),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const GetToKnowTinkercad())),
                    ),
                    QuizCard('A R D U I N O    S Y N T A X', Color(0xFF81D4FA)),
                    QuizCard('A R D U I N O    I/O', Color(0xFFCE93D8)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  final String title;
  final Color color;

  const QuizCard(this.title, this.color, {Key? key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (title == 'B A S I C    A R D U I N O') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const BasicArduinoQuiz()));
        } else if (title == 'A R D U I N O    S Y N T A X') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ArduinoSyntax()));
        } else if (title == 'A R D U I N O    I/O') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Arduinoio()));
        }
      },
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          ],
        ),
      ),
    ),
    );
  }
}

class QuizCardStacked extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color color;
  final VoidCallback? onTap; // Added a VoidCallback for optional onTap functionality

  const QuizCardStacked(this.firstText, this.secondText, this.color, {this.onTap, Key? key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Use the provided onTap callback if available
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                firstText,
                style: const TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                secondText,
                style: const TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}