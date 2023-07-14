part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  
  @override
  List<Object> get props => [];
}

class PaymentInitialState extends PaymentState {
    @override
  List<Object> get props => [];
}
class PaymentLoadingState extends PaymentState {
    @override
  List<Object> get props => [];
}
class SignOutState extends PaymentState {}
class PaymentSuccessState extends PaymentState {
    @override
  List<Object> get props => [];
}

class PaymentErrorState extends PaymentState {
  final Map<String, String> fieldErrors;
  const PaymentErrorState({
    required this.fieldErrors,

  });
    @override
  List<Object> get props => [fieldErrors];
}
class PaymentNavigateState extends PaymentState {
    @override
  List<Object> get props => [];
}

