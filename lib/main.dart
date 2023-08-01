import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shunting_yard_algorithm/bloc/expression_bloc.dart';
import 'package:shunting_yard_algorithm/ui/expression_parser_screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expression Parser',
      home: BlocProvider(
        create: (context) => ExpressionBloc(),
        child: ExpressionParserScreen(),
      ),
    );
  }
}