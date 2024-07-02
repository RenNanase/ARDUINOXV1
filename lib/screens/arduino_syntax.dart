import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ArduinoSyntax extends StatefulWidget {
  const ArduinoSyntax({super.key});

  @override
  _ArduinoSyntaxState createState() => _ArduinoSyntaxState();
}

class _ArduinoSyntaxState extends State<ArduinoSyntax>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int userScore = 0;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
      'In Arduino, every command must end with a semicolon (;).',
      'answer': true,
      //'image': 'lib/images/pink.png',
    },
    {
      'question': 'The void setup() function runs only once when you start the Arduino.',
      'answer': true,
    },
    {
      'question':
      'The void loop() function runs repeatedly in an Arduino program',
      'answer': true,
    },
    {
      'question':
      'In Arduino code, digitalWrite() is used to set a pin to HIGH or LOW.',
      'answer': true,
    },
    {
      'question':
      'In Arduino, delay(1000); makes the program wait for one second.',
      'answer': true,
    },
    {
      'question':
      'The loop() function runs only once and then stops.',
      'answer': false,
    },
    {
      'question': 'To turn on an LED connected to pin 13, you use digitalWrite(13, HIGH);.',
      'answer': true,
    },
    {
      'question':
      'Comments in Arduino code start with **.',
      'answer': false,
    },
    {
      'question':
      'The void keyword indicates that a function returns an integer value.',
      'answer': false,
    },
    {
      'question':
      'The statement if (x > 10) checks if x is less than 10.',
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
      await userCollection.doc(user.uid).update({'Arduino Syntax': userScore});
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
    home: ArduinoSyntax(),
  ));
}
