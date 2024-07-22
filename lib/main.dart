import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String equation = "";
  String exp = "";
  String res = "";
  String first = "", second = "";
  String op = "";

  buttonPressed(btntext) {
    setState(() {
      if (btntext == 'AC') {
        equation = "";
        res = "";
      } else if (btntext == 'C') {
        equation = equation.substring(0, equation.length - 1);
      } else if (btntext == "ANS") {
        equation = res;
        res = "";
      } else if (btntext == "=") {
        exp = equation;
        exp = exp.replaceAll('×', '*');
        exp = exp.replaceAll('÷', '/');
        exp = exp.replaceAll('%', '%');
        try {
          Parser p = Parser();
          Expression expression = p.parse(exp);
          ContextModel cn = ContextModel();
          res = '${expression.evaluate(EvaluationType.REAL, cn)}';
        } catch (e) {}
      } else {
        equation = equation + btntext;
      }
    });
  }

  Widget buttons(String btntext, Color txtcolor, Color btncolor,
      double btnwidth, double txtsize) {
    return InkWell(
      onTap: () {
        buttonPressed(btntext);
      },
      child: Container(
        height: 50,
        width: btnwidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200), color: btncolor),
        child: Text(
          btntext,
          style: TextStyle(
            color: txtcolor,
            fontSize: txtsize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerRight,
              height: 100,
              width: double.infinity,
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              height: 100,
              width: double.infinity,
              child: Text(
                res,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Divider(
            height: 5,
            thickness: 0.3,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 110, bottom: 10, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttons("AC", Colors.lightBlue, Colors.transparent, 50, 28),
                    buttons("C", Colors.lightBlue, Colors.transparent, 50, 28),
                    buttons(".", Colors.lightBlue, Colors.transparent, 50, 30),
                    buttons("÷", Colors.lightBlue, Colors.transparent, 50, 30),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttons("7", Colors.black, Colors.transparent, 50, 30),
                    buttons("8", Colors.black, Colors.transparent, 50, 30),
                    buttons("9", Colors.black, Colors.transparent, 50, 30),
                    buttons("×", Colors.lightBlue, Colors.transparent, 50, 30),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttons("4", Colors.black, Colors.transparent, 50, 30),
                    buttons("5", Colors.black, Colors.transparent, 50, 30),
                    buttons("6", Colors.black, Colors.transparent, 50, 30),
                    buttons("-", Colors.lightBlue, Colors.transparent, 50, 30),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttons("1", Colors.black, Colors.transparent, 50, 30),
                    buttons("2", Colors.black, Colors.transparent, 50, 30),
                    buttons("3", Colors.black, Colors.transparent, 50, 30),
                    buttons("+", Colors.lightBlue, Colors.transparent, 50, 30),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttons("0", Colors.black, Colors.transparent, 50, 30),
                    buttons(
                        "ANS", Colors.lightBlue, Colors.transparent, 50, 20),
                    buttons("=", Colors.white, Colors.lightBlue, 100, 35),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
