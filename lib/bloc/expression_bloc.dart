
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shunting_yard_algorithm/utils/expression_parser_utils.dart';

part 'expression_event.dart';
part 'expression_state.dart';

class ExpressionBloc extends Bloc<ExpressionEvent, ExpressionState> {

  ExpressionBloc() : super(ExpressionInitial()) {
    on<ExpressionEvent>((event, emit) {
      if (event is Expression) {
        String expression = event.v;
        String errorMessage = validateExpression(expression);

        if (errorMessage.isNotEmpty) {
          emit (ExpressionParserState.withError(errorMessage));
        } else {
          try {
            double result =evaluateExpression(expression);
            emit( ExpressionParserState.withResult('$expression = $result'));
          } catch (e) {
            emit( ExpressionParserState.withError('Error: Invalid expression'));
          }
        }
      }    });
  }

}
