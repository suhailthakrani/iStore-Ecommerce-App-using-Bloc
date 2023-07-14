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

class PaymentCardSavedEvent extends PaymentEvent {
  final bool isCardSaved;
  const PaymentCardSavedEvent(
    this.isCardSaved,
  );

  @override
  List<Object> get props => [isCardSaved];
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
  const PaymentButtonPressedEvent({
    required this.name,
    required this.email,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvcNo,
    required this.country,
    required this.zipCode,
    required this.isCardSaved,
  });

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
