import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
import '../../repositories/authentication_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository authRepository;
  SignUpBloc(this.authRepository) : super(SignUpInitialState()) {
    on<SignUpInitialEvent>(mapSignUpInitialEventWithState);
    on<SignUpButtonPressedEvent>(mapSignUpButtonPressedEventWithState);
    on<SignUpTextFieldsChangedEvent>(mapSignUpTextFieldsChangedEventWithState);
  }
  Future<void> mapSignUpTextFieldsChangedEventWithState(
      SignUpTextFieldsChangedEvent event, Emitter<SignUpState> emit) async {
    Map<String, String> fieldErrors = <String, String>{};
    RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(event.userModel.email)) {
      fieldErrors["email"] = "Please enter a valid email!";
    }
    if (event.userModel.name.isEmpty || event.userModel.name.length < 5) {
      fieldErrors["name"] = "Please enter a valid username!";
    }
    if (event.userModel.password.isEmpty ||
        event.userModel.password.length < 8) {
      fieldErrors["password"] =  "Password must be at least 8 characters long!";
    }
    if (event.userModel.confrimP != event.userModel.password) {
      fieldErrors["confrimP"] =  "Passwords don't match!";
    }
    if (fieldErrors.isNotEmpty) {
      emit(SignUpErrorState(fieldErrors: fieldErrors));
    } else {
      emit(SignUpSuccessState());
    }
  }

  Future<void> mapSignUpButtonPressedEventWithState(
      SignUpButtonPressedEvent event, Emitter<SignUpState> emit) async {
    Map<String, String> fieldErrors = <String, String>{};
    RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(event.userModel.email)) {
      fieldErrors["email"] = "Please enter a valid email!";
    }
    if (event.userModel.name.isEmpty || event.userModel.name.length < 5) {
      fieldErrors["name"] = "Please enter a valid username!";
    }
    if (event.userModel.password.isEmpty ||
        event.userModel.password.length < 8) {
      fieldErrors["password"] = "Password must be at least 8 characters long!";
    }
     if (event.userModel.confrimP.isEmpty ||
        event.userModel.confrimP.length < 8) {
      fieldErrors["confrimP"] = "Password must be at least 8 characters long!";
    }
    if (event.userModel.confrimP != event.userModel.password) {
      fieldErrors["confrimP"] =  "Passwords don't match!";
    }
    if (fieldErrors.isNotEmpty) {
      emit(SignUpErrorState(fieldErrors: fieldErrors));
    } else {
      await authRepository.register(userModel: event.userModel);
      emit(SignUpNavigateState());
    }
  }

  FutureOr<void> mapSignUpInitialEventWithState(
      SignUpInitialEvent event, Emitter<SignUpState> emit) {
    try {
      emit(SignUpLoadingState());

      emit(SignUpSuccessState());
    } on Exception catch (e) {
      emit(SignUpErrorState(
        fieldErrors: {"other": "$e"},
      ));
    }
  }
}
