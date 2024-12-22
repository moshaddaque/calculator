import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return InkWell(
      onTap: () {
        calculation(btntxt);
      },
      child: Container(
        height: 65,
        width: 65,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: btncolor,
        ),
        child: Center(
          child: Text(
            btntxt,
            style: TextStyle(
              fontSize: 30,
              color: txtcolor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Simple Calculator",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),

              //===== buttons ========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton("AC", Colors.grey, Colors.black),
                  calcButton('+/-', Colors.grey, Colors.black),
                  calcButton('%', Colors.grey, Colors.black),
                  calcButton('/', Colors.amber[700]!, Colors.white),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcButton('7', Colors.grey[850]!, Colors.white),
                  calcButton('8', Colors.grey[850]!, Colors.white),
                  calcButton('9', Colors.grey[850]!, Colors.white),
                  calcButton('x', Colors.amber[700]!, Colors.white),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcButton('4', Colors.grey[850]!, Colors.white),
                  calcButton('5', Colors.grey[850]!, Colors.white),
                  calcButton('6', Colors.grey[850]!, Colors.white),
                  calcButton('-', Colors.amber[700]!, Colors.white),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcButton('1', Colors.grey[850]!, Colors.white),
                  calcButton('2', Colors.grey[850]!, Colors.white),
                  calcButton('3', Colors.grey[850]!, Colors.white),
                  calcButton('+', Colors.amber[700]!, Colors.white),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      calculation('0');
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(65, 10, 65, 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          '0',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  calcButton('.', Colors.grey[850]!, Colors.white),
                  calcButton('=', Colors.amber[700]!, Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // calculator logic
  dynamic text = '0';
  double number1 = 0;
  double number2 = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(String btnText) {
    if (btnText == 'AC') {
      text = '0';
      number1 = 0;
      number2 = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (number1 == 0) {
        number1 = double.parse(result);
      } else {
        number2 = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (number1 / 100);
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-$result';
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (number1 + number2).toString();
    number1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (number1 - number2).toString();
    number1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (number1 * number2).toString();
    number1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (number1 / number2).toStringAsFixed(2);
    number1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
