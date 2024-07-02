import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BasicArduinoQuiz extends StatefulWidget {
  const BasicArduinoQuiz({super.key});

  @override
  _BasicArduinoQuizState createState() => _BasicArduinoQuizState();
}

class _BasicArduinoQuizState extends State<BasicArduinoQuiz>
    with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  int userScore = 0;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
      'The Arduino IDE (Integrated Development Environment) is used for writing and uploading code to Arduino boards',
      'answer': true,
      //'image': 'lib/images/pink.png',
    },
    {
      'question': 'The analog pins on an Arduino can only read analog signals',
      'answer': false,
    },
    {
      'question':
      'The digital pins on an Arduino can be used for both input and output.',
      'answer': true,
    },
    {
      'question':
      'The pinMode function is used to set a pin as either INPUT or OUTPUT.',
      'answer': true,
    },
    {
      'question':
      'The analogWrite function can be used to generate PWM (Pulse Width Modulation) signals',
      'answer': true,
    },
    {
      'question':
      'The digitalRead function returns HIGH if the pin voltage is 5V and LOW if it is 0V.',
      'answer': true,
    },
    {
      'question': 'The Arduino Uno board is powered by a 9V battery',
      'answer': false,
    },
    {
      'question':
      'The setup function is called only once when the Arduino starts.',
      'answer': true,
    },
    {
      'question':
      ' The map function is used to scale a value from one range to another.',
      'answer': true,
    },
    {
      'question':
      'The Arduino Uno board has 14 digital pins and 6 analog pins',
      'answer': true,
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
      await userCollection.doc(user.uid).update({'Basic Arduino': userScore});
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
    home: BasicArduinoQuiz(),
  ));
}
