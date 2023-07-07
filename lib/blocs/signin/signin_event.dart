// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}
class SignInInitialEvent extends SignInEvent {
  const SignInInitialEvent();

  @override
  List<Object> get props => [];
}

class SignInTextFieldsChangedEvent extends SignInEvent {
  final String email;
  final String password;
  const SignInTextFieldsChangedEvent(
    this.email,
    this.password,
  );

  @override
  List<Object> get props => [email, password];
}
class SignInButtonPressedeEvent extends SignInEvent {
  final String email;
  final String password;
  const SignInButtonPressedeEvent(
    this.email,
    this.password,
  );

  @override
  List<Object> get props => [email, password];
}


