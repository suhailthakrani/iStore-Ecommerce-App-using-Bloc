import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
