import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shunting_yard_algorithm/bloc/expression_bloc.dart';
import 'package:shunting_yard_algorithm/constants/constants.dart';

class ExpressionParserScreen extends StatelessWidget {
  const ExpressionParserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ExpressionBloc>(context);
    TextEditingController expressionController = TextEditingController();
    String result = '';
    String errorMessage = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: expressionController,
                decoration: const InputDecoration(
                  labelText: Constants.labelText,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  bloc.add(Expression(v:expressionController.text));
                },
                child: const Text(Constants.evaluate),
              ),
              const SizedBox(height: 16),
              BlocBuilder<ExpressionBloc, ExpressionState>(
                builder: (context, state) {
                  if(state is ExpressionParserState) {
                    result = state.result;
                    errorMessage = state.errorMessage;
                  }
                  return Text(
                    errorMessage.isNotEmpty ? errorMessage : result,
                    style: const TextStyle(fontSize: 18),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}