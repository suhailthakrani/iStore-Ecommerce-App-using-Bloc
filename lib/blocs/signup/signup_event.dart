// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}
class SignUpInitialEvent extends SignUpEvent {
  const SignUpInitialEvent();

  @override
  List<Object> get props => [];
}
class SignUpTextFieldsChangedEvent extends SignUpEvent {

  final UserModel userModel;
  const SignUpTextFieldsChangedEvent(
    this.userModel,
  );

  @override
  List<Object> get props => [userModel];
}

class SignUpButtonPressedEvent extends SignUpEvent {
  final UserModel userModel;
  const SignUpButtonPressedEvent(
    this.userModel,
  );

  @override
  List<Object> get props => [userModel];
}
