import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final tickIcon = Icon(Icons.check, color: Colors.green);
  final crossIcon = Icon(Icons.clear, color: Colors.red);
  int count = 0;
  int correctA = 0;
  List<Icon> iconsList = [];

  List<Question> sQuestions = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz App',
          ),
        ),
        backgroundColor: Color(0xFF333333),
        body: _body(),
      ),
    );
  }

  _body() {
    if (sQuestions.length != 0) {
      ///
      /// Column1
      ///
      return Column(
        // Divide the the vertical space between the children
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        // Stretch the children horizontally to the screen size
        // as we need to stretch the buttons
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Center(

              ///
              /// Text Widget with some padding
              ///
              child: Padding(
            padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
            child: Text(
              _dQuestion(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          )),

          ///
          /// Column2
          ///
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ///
              /// Skip Button
              ///
              RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                color: Colors.white,
                onPressed: () {
                  _checkAnswer('skip');
                },
              ),

              ///
              /// To give some space between buttons
              ///
              SizedBox(height: 8),

              ///
              /// True Button
              ///
              RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'True',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                color: Colors.green,
                onPressed: () {
                  _checkAnswer(true);
                },
              ),

              ///
              /// To give some space between buttons
              ///
              SizedBox(height: 8),

              ///
              /// False Button
              ///
              RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'False',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                color: Colors.red,
                onPressed: () {
                  _checkAnswer(false);
                },
              ),

              ///
              /// Row for Tick-Cross Icons to align them horizontally.
              ///
              Container(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: iconsList,
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                """Quiz Finished
                Your Score $correctA""",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          )
        ],
      );
    }
  }

  _checkAnswer(var selectedAnswer) {
    if (selectedAnswer == 'skip') {
      setState(() {
        if (count < sQuestions.length - 1)
          count++;
        else if ((count == sQuestions.length - 1) && (iconsList.length != 0))
          count = 0;
        else if ((count == sQuestions.length - 1) && (iconsList.length == 0))
          count = 0;
      });
    } else if (selectedAnswer == sQuestions[count].correctAnswer) {
      //Correct answer
      setState(() {
        iconsList.add(tickIcon);
        correctA++;
        // Check if don't cross list size limit which will result in error
        if (count < sQuestions.length - 1)
          sQuestions.removeAt(count);
        else if ((count == sQuestions.length - 1) && (iconsList.length != 0)) {
          sQuestions.removeAt(count);
          count = 0;
        }
      });
    } else {
      //Incorrect answer
      setState(() {
        iconsList.add(crossIcon);

        // Check if don't cross list size limit which will result in error
        if (count < sQuestions.length - 1)
          sQuestions.removeAt(count);
        else if ((count == sQuestions.length - 1) && (iconsList.length != 0)) {
          sQuestions.removeAt(count);
          count = 0;
        }
      });
    }
  }

  String _dQuestion() {
    return sQuestions[count].question;
  }
}

class Question {
  String question;
  bool correctAnswer;

  Question(this.question, this.correctAnswer);
}
