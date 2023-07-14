import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/repositories/payment_repo/payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
    final PaymentRepository paymentRepository;
  bool showPass = false;
  PaymentBloc(this.paymentRepository) : super(PaymentInitialState()) {
    on<PaymentInitialEvent>(mapPaymentInitialEventWithState);
    on<PaymentButtonPressedEvent>(mapPaymentButtonPressedEventWithState);
    on<PaymentTextFieldsChangedEvent>(mapPaymentTextFieldsChangedEventWithState);
  }
  FutureOr<void> mapPaymentTextFieldsChangedEventWithState(
      PaymentTextFieldsChangedEvent event, Emitter<PaymentState> emit) async {
    Map<String, String> fieldErrors = <String, String>{};
    if (paymentRepository.validateEmail(event.email)) {
      fieldErrors["email"] = "Please enter a valid email.";
    }
    if (event.name.isEmpty || event.name.length < 5) {
      fieldErrors["name"] = "Please enter a valid username.";
    }
    if (!paymentRepository.validateCreditCardNumber(event.cardNumber)) {
      fieldErrors["card"] =  "Please enter the correct card number.";
    }
    if (!paymentRepository.validateExpirationDate(event.expiryDate)) {
      fieldErrors["expiryDate"] =  "Invalid expiration date.";
    }
    if (!paymentRepository.validateCvc(event.cvcNo)) {
      fieldErrors["cvc"] =  "Invalid CVC.";
    }
    if (!paymentRepository.validateZipCode(event.zipCode)) {
      fieldErrors["zip"] =  "Invalid Zip Code.";
    }
    if (fieldErrors.isNotEmpty) {
      emit(PaymentErrorState(fieldErrors: fieldErrors));
    } else {
      emit(PaymentSuccessState());
    }
  }

  FutureOr<void> mapPaymentButtonPressedEventWithState(
      PaymentButtonPressedEvent event, Emitter<PaymentState> emit) async {
    Map<String, String> fieldErrors = <String, String>{};
    if (paymentRepository.validateEmail(event.email)) {
      fieldErrors["email"] = "Please enter a valid email.";
    }
    if (event.name.isEmpty || event.name.length < 5) {
      fieldErrors["name"] = "Please enter a valid username.";
    }
    if (!paymentRepository.validateCreditCardNumber(event.cardNumber)) {
      fieldErrors["card"] =  "Please enter the correct card number.";
    }
    if (!paymentRepository.validateExpirationDate(event.expiryDate)) {
      fieldErrors["expiryDate"] =  "Invalid expiration date.";
    }
    if (!paymentRepository.validateCvc(event.cvcNo)) {
      fieldErrors["cvc"] =  "Invalid CVC.";
    }
    if (!paymentRepository.validateZipCode(event.zipCode)) {
      fieldErrors["zip"] =  "Invalid Zip Code.";
    }
    if (fieldErrors.isNotEmpty) {
      emit(PaymentErrorState(fieldErrors: fieldErrors));
    } else {
  
      emit(PaymentNavigateState());
    }
  }

  FutureOr<void> mapPaymentInitialEventWithState(
      PaymentInitialEvent event, Emitter<PaymentState> emit) {
    try {
      emit(PaymentLoadingState());

      emit(PaymentSuccessState());
    } on Exception catch (e) {
      emit(PaymentErrorState(
        fieldErrors: {"other": "$e"},
      ));
    }
  }
}
