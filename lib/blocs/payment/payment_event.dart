// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentInitialEvent extends PaymentEvent {
  const PaymentInitialEvent();

  @override
  List<Object> get props => [];
}

class PaymentTextFieldsChangedEvent extends PaymentEvent {
  final String name;
  final String email;
  final String cardNumber;
  final String expiryDate;
  final String cvcNo;
  final String zipCode;
  const PaymentTextFieldsChangedEvent(
    this.name,
    this.email,
    this.cardNumber,
    this.expiryDate,
    this.cvcNo,
    this.zipCode,
  );

  @override
  List<Object> get props => [
        name,
        email,
        cardNumber,
        expiryDate,
        cvcNo,
        zipCode,
      ];
}

class PaymentButtonPressedEvent extends PaymentEvent {
  final String name;
  final String email;
  final String cardNumber;
  final String expiryDate;
  final String cvcNo;
  final String country;
  final String zipCode;
  final bool isCardSaved;
  const PaymentButtonPressedEvent(
    this.name,
    this.email,
    this.cardNumber,
    this.expiryDate,
    this.cvcNo,
    this.country,
    this.zipCode,
    this.isCardSaved,
  );

  @override
  List<Object> get props => [
        name,
        email,
        cardNumber,
        expiryDate,
        cvcNo,
        country,
        zipCode,
        isCardSaved,
      ];
}
