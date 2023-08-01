part of 'expression_bloc.dart';



// enum ExpressionEvent  {
//   Evaluate,
//   Clear, // Add this event if you want to allow the user to clear the input
// }

abstract class ExpressionEvent {

}

class Expression extends ExpressionEvent{
  String v;
  Expression({required this.v});
}
