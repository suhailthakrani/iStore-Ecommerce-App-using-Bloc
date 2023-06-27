// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}


class SignUpInitialState extends SignUpState {
    @override
  List<Object> get props => [];
}
class SignUpLoadingState extends SignUpState {
    @override
  List<Object> get props => [];
}
class SignOutState extends SignUpState {}
class SignUpSuccessState extends SignUpState {
    @override
  List<Object> get props => [];
}

class SignUpErrorState extends SignUpState {
  final Map<String, String> fieldErrors;
  const SignUpErrorState({
    required this.fieldErrors,

  });
    @override
  List<Object> get props => [fieldErrors];
}
class SignUpNavigateState extends SignUpState {
    @override
  List<Object> get props => [];
}

