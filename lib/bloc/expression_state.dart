part of 'expression_bloc.dart';

@immutable
abstract class ExpressionState {}

class ExpressionInitial extends ExpressionState {}
class ExpressionParserState  extends ExpressionState{
  final String result;
  final String errorMessage;

  ExpressionParserState({required this.result, required this.errorMessage});

  // Factory methods for convenient state creation
  factory ExpressionParserState.initial() => ExpressionParserState(result: '', errorMessage: '');
  factory ExpressionParserState.withResult(String result) => ExpressionParserState(result: result, errorMessage: '');
  factory ExpressionParserState.withError(String errorMessage) =>
      ExpressionParserState(result: '', errorMessage: errorMessage);
}
