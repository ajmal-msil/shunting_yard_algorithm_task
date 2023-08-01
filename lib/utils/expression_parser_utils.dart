import 'dart:math';

double evaluateExpression(String expression) {
  // Regular expression to split the expression into tokens
  final RegExp tokenRegExp = RegExp(r'(\d+|\+|\-|\*|\/|\^|\(|\)|\s+)');

  List<String> outputQueue = [];
  List<String> operatorStack = [];

  Map<String, int> precedence = {
    '^': 3,
    '*': 2,
    '/': 2,
    '+': 1,
    '-': 1,
  };

  List<String> tokens = tokenRegExp.allMatches(expression).map((match) => match.group(0)!).toList();

  void processOperator(String op) {
    while (operatorStack.isNotEmpty &&
        precedence[op]! <= precedence[operatorStack.last]!) {
      outputQueue.add(operatorStack.removeLast());
    }
    operatorStack.add(op);
  }

  for (String token in tokens) {
    if (double.tryParse(token) != null) {
      outputQueue.add(token);
    } else if (token == '(') {
      operatorStack.add(token);
    } else if (token == ')') {
      while (operatorStack.isNotEmpty && operatorStack.last != '(') {
        outputQueue.add(operatorStack.removeLast());
      }
      operatorStack.removeLast(); // Pop the '(' from the stack
    } else if (precedence.containsKey(token)) {
      processOperator(token);
    } else {
      throw Exception('Error: Invalid token $token');
    }
  }

  while (operatorStack.isNotEmpty) {
    outputQueue.add(operatorStack.removeLast());
  }

  List<double> evaluationStack = [];
  for (String token in outputQueue) {
    if (double.tryParse(token) != null) {
      evaluationStack.add(double.parse(token));
    } else if (precedence.containsKey(token)) {
      if (evaluationStack.length < 2) {
        throw Exception('Error: Invalid expression');
      }
      double b = evaluationStack.removeLast();
      double a = evaluationStack.removeLast();
      double result;

      switch (token) {
        case '^':
          result = pow(a, b).toDouble();
          break;
        case '*':
          result = a * b;
          break;
        case '/':
          result = a / b;
          break;
        case '+':
          result = a + b;
          break;
        case '-':
          result = a - b;
          break;
        default:
          throw Exception('Error: Invalid operator');
      }
      evaluationStack.add(result);
    } else {
      throw Exception('Error: Invalid token $token');
    }
  }

  if (evaluationStack.length != 1) {
    throw Exception('Error: Invalid expression');
  }

  return evaluationStack.single;
}

String validateExpression(String expression) {
  // Regular expression to split the expression into tokens
  final RegExp tokenRegExp = RegExp(r'(\d+|\+|\-|\*|\/|\^|\(|\)|\s+)');

  List<String> operatorStack = [];
  Map<String, num> precedence = {
    '^': 3,
    '*': 2,
    '/': 2,
    '+': 1,
    '-': 1,
  };

  List<String> tokens = tokenRegExp.allMatches(expression).map((match) => match.group(0)!).toList();

  void processOperator(String op) {
    while (operatorStack.isNotEmpty &&
        precedence[op]! <= precedence[operatorStack.last]!) {
      operatorStack.removeLast();
    }
    operatorStack.add(op);
  }

  for (String token in tokens) {
    if (double.tryParse(token) != null) {
      // Token is a number, skip processing
    } else if (token == '(') {
      operatorStack.add(token);
    } else if (token == ')') {
      if (operatorStack.isEmpty || operatorStack.last != '(') {
        return 'Error: Mismatched parentheses';
      }
      operatorStack.removeLast(); // Pop the '(' from the stack
    } else if (precedence.containsKey(token)) {
      processOperator(token);
    } else {
      return 'Error: Invalid token $token';
    }
  }

  if (operatorStack.contains('(') || operatorStack.contains(')')) {
    return 'Error: Mismatched parentheses';
  }
  return '';
}

bool isDigitOrOperator(String char) {
  return double.tryParse(char) != null || isOperator(char);
}

bool isOperator(String char) {
  return char == '+' || char == '-' || char == '*' || char == '/' || char == '^';
}

