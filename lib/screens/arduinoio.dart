import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Arduinoio extends StatefulWidget {
  const Arduinoio({super.key});

  @override
  _ArduinoioState createState() => _ArduinoioState();
}

class _ArduinoioState extends State<Arduinoio>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int userScore = 0;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
      ' Digital pins on the Arduino can be used as both input and output.',
      'answer': true,
      //'image': 'lib/images/pink.png',
    },
    {
      'question': 'Analog pins on the Arduino can only be used for input.',
      'answer': false,
    },
    {
      'question':
      ' An LED connected to a digital pin requires a resistor to prevent damage to the LED.',
      'answer': true,
    },
    {
      'question':
      'A pushbutton connected to an Arduino should be connected to a digital input pin.',
      'answer': true,
    },
    {
      'question':
      'The Arduino can directly power a standard servo motor without any additional components.v',
      'answer': false,
    },
    {
      'question':
      'A potentiometer connected to an analog pin can provide a range of values from 0 to 1023.',
      'answer': true,
    },
    {
      'question': 'The Arduino PWM pins can simulate analog output.',
      'answer': true,
    },
    {
      'question':
      'A temperature sensor can be connected directly to a digital pin for accurate readings.',
      'answer': false,
    },
    {
      'question':
      ' An LDR (Light Dependent Resistor) can be used with an analog input pin to measure light intensity.',
      'answer': true,
    },
    {
      'question':
      'The Arduino can read the state of a connected switch without using any resistors.',
      'answer': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Adjust animation duration as needed
    );
    _updateProgress();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateProgress() {
    _progressAnimation = Tween<double>(
      begin: currentQuestionIndex.toDouble() / questions.length,
      end: (currentQuestionIndex + 1).toDouble() / questions.length,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {}); // Update UI on animation progress
      });
    _animationController.forward(from: 0);
  }

  void checkAnswer(bool selectedAnswer) {
    if (selectedAnswer == questions[currentQuestionIndex]['answer']) {
      setState(() {
        userScore++;
      });
    }
    // Move to the next question
    setState(() {
      currentQuestionIndex++;
      if (currentQuestionIndex < questions.length) {
        _updateProgress();
      } else {
        _saveScoreToFirestore();
      }
    });
  }

  Future<void> _saveScoreToFirestore() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userCollection = FirebaseFirestore.instance.collection('Users');
      await userCollection.doc(user.uid).update({'Arduino I/O': userScore});
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      userScore = 0;
      _animationController.reset();
      _updateProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('True/False Quiz'),
        backgroundColor: Colors.pink[100], // Set app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (currentQuestionIndex < questions.length)
              LinearProgressIndicator(
                value: _progressAnimation.value,
                minHeight: 10,
                backgroundColor: Colors.pink[50],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              ),
            const SizedBox(height: 20),
            if (currentQuestionIndex < questions.length)
              Expanded(
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (questions[currentQuestionIndex]
                            .containsKey('image'))
                          Image.asset(
                            questions[currentQuestionIndex]['image'],
                            height: 200,
                          ),
                        const SizedBox(height: 20),
                        Text(
                          questions[currentQuestionIndex]['question'],
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (currentQuestionIndex < questions.length)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => checkAnswer(true),
                    child: const Text('True'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => checkAnswer(false),
                    child: const Text('False'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            if (currentQuestionIndex == questions.length)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/congrats.png',
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Quiz Completed! Your Score: $userScore / ${questions.length}',
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: resetQuiz,
                    child: const Text('Restart Quiz'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Arduinoio(),
  ));
}
