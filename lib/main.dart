import 'dart:ui';
import 'package:calci/btns.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Color background = Color(0xff1D3557);
  // Color card = Color(0xff457B9D);
  // Color textcolor = Color(0xffF1FAEE);
  Color background = Colors.white;
  Color card = Color(0xffEFF7F6);
  Color textcolor = Colors.black;
  Color questioncolor = Colors.black;
  Color answercolor = Colors.black;
  var question = '';
  var answer = '';
  // ignore: non_constant_identifier_names
  double question_font_size = 44;
  // ignore: non_constant_identifier_names
  double answer_font_size = 40;

  void darkmode() {
    setState(() {
      if (background == Colors.black) {
        background = Colors.white;
        card = Color(0xffEFF7F6);
        textcolor = Colors.black;
        answercolor = Colors.black;
        questioncolor = Colors.black87;
      } else {
        background = Colors.black;
        card = Colors.transparent;
        textcolor = Colors.white;
        answercolor = Colors.blue[100];
        questioncolor = Colors.white;
      }
    });
  }

  void updatestate() {
    setState(() {
      question_font_size = 30;
      answer_font_size = 46;
    });
  }

  final List<String> btns = [
    'c',
    'Del',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '00',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: EdgeInsets.all(25),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer,
                        style: TextStyle(
                            fontSize: answer_font_size,
                            color: answercolor,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(question,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: question_font_size,
                              color: questioncolor,
                              fontWeight: FontWeight.w600))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  color: card,
                  child: GridView.builder(
                      itemCount: btns.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Mybtn(
                            btntapped: () {
                              setState(() {
                                question = '';
                                answer = '';
                                question_font_size = 44;
                                if (background == Colors.white) {
                                  questioncolor = Colors.black;
                                } else {
                                  questioncolor = Colors.white;
                                }
                              });
                            },
                            btntext: btns[index],
                            color: Colors.greenAccent[100],
                            textcolor: Color(0xff000000),
                          );
                        } //if==0

                        else if (index == 1) {
                          return Mybtn(
                              btntapped: () {
                                setState(() {
                                  question = question.substring(
                                      0, question.length - 1);
                                  question_font_size = 44;
                                  answer = '';
                                });
                              },
                              btntext: btns[index],
                              color: Colors.redAccent[100],
                              textcolor: Color(0xff000000));
                        } //if==1

                        else if (index == btns.length - 1) {
                          return Mybtn(
                            btntapped: () {
                              setState(() {
                                equalpressed();
                              });
                            },
                            longpressd: () {
                              setState(() {
                                equallongpressed();
                              });
                            },
                            btntext: btns[index],
                            color: Color(0xffA8DADC),
                            textcolor: Color(0xff1D3557),
                          );
                        } //isequal

                        else {
                          return Mybtn(
                            btntapped: () {
                              setState(() {
                                question += btns[index];
                              });
                            },
                            btntext: btns[index],
                            color: card,
                            textcolor: textcolor,
                          );
                        }
                      }),
                ),
              ),
            ),
          ),
        ], //children
      ),
    );
  }

  void equalpressed() {
    updatestate();

    String userquestion = question;

    userquestion = userquestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(userquestion);
    ContextModel cm = ContextModel();
    double e = exp.evaluate(EvaluationType.REAL, cm);
    var eval = e.toString();
    answer = e.toStringAsFixed(1);
  }

  void equallongpressed() {
    darkmode();
  }
}
