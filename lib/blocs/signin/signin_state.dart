part of 'signin_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
  
  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {
    @override
  List<Object> get props => [];
}
class SignOutState extends SignInState {}
class SignInSuccessState extends SignInState {
    @override
  List<Object> get props => [];
}
class SignInErrorState extends SignInState {
    @override
  List<Object> get props => [];
}

