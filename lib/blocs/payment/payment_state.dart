// ignore_for_file: public_member_api_docs, sort_constructors_first
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
class PaymentSuccessState extends PaymentState {
    @override
  List<Object> get props => [];
}
class PaymentCardCheckedState extends PaymentState {
  final bool isCardSaved;
  const PaymentCardCheckedState({
    required this.isCardSaved,
  });
    @override
  List<Object> get props => [isCardSaved];
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

