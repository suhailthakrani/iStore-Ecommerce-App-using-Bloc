// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signin_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
  
  @override
  List<Object> get props => [];
}
abstract class SignInActionState extends SignInState {
  const SignInActionState();
  
  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {
    @override
  List<Object> get props => [];
}
class SignInLoadingState extends SignInState {
    @override
  List<Object> get props => [];
}
class SignOutState extends SignInState {}
class SignInSuccessState extends SignInState {

    @override
  List<Object> get props => [];
}
class SignInNavigateState extends SignInState {

    @override
  List<Object> get props => [];
}
class SignInErrorState extends SignInState {
  final Map<String, String> errors;
  const SignInErrorState({
    required this.errors,
  });
    @override
  List<Object> get props => [errors];
}
class SignInInvalidCredentialState extends SignInActionState {
  final String error;
  const SignInInvalidCredentialState({
    required this.error,
  });
      @override
  List<Object> get props => [error];
}

