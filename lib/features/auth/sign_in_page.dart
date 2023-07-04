// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/blocs/signup/signup_bloc.dart';
import 'package:bloc_cart_app/features/auth/sign_up_page.dart';
import 'package:bloc_cart_app/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/commons/widgets/custom_text_field.dart';

import '../../blocs/home/home_bloc.dart';
import '../../blocs/signin/signin_bloc.dart';

class SignInPage extends StatelessWidget {
  SignInBloc signInBloc;
  SignInPage({
    Key? key,
    required this.signInBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    signInBloc = BlocProvider.of<SignInBloc>(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "S I G N I N  H E R E !",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green,
            child: FlutterLogo(
              size: 50,
            ),
          ),
          const SizedBox(height: 80),
          CustomTextField(
            hint: "Enter your email",
            controller: emailController,
            prefix: const Icon(
              Icons.email_outlined,
            ),
            onChanged: (email) {
              context.read<SignInBloc>().add(
                    SignInTextFieldsChangedEvent(
                      email,
                      passController.text,
                    ),
                  );
            },
          ),
          const SizedBox(height: 5),
          BlocBuilder<SignInBloc, SignInState>(
            bloc: signInBloc,
            builder: (context, state) {
              print("-------------1----------------");
              print(state);
              if (state is SignInErrorState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.errors["email"] != null
                        ? Text(state.errors["email"] ?? "")
                        : Container(),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hint: "Enter password",
            controller: passController,
            onChanged: (pass) {
              context.read<SignInBloc>().add(
                    SignInTextFieldsChangedEvent(
                      emailController.text,
                      pass,
                    ),
                  );
            },
            prefix: const Icon(
              Icons.person_outline,
            ),
          ),
          BlocBuilder<SignInBloc, SignInState>(
            bloc: signInBloc,
            builder: (context, state) {
              print("-------------2----------------");
              print(state);
              if (state is SignInErrorState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state.errors["password"] != null
                        ? Text(state.errors["password"] ?? "")
                        : Container(),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          const SizedBox(height: 40),
          BlocConsumer<SignInBloc, SignInState>(
            buildWhen: (previous, current) => current is! SignInActionState,
            listener: (context, state) {
              if (state is SignInInvalidCredentialState) {
                SnackBar snackBar = SnackBar(
                  content: Text(
                    state.error,
                    style: TextStyle(color: Colors.red,),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state is SignInNavigateState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<HomeBloc>(context),
                      child: const HomePage(),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              print("------------ " + state.toString());
              return ElevatedButton(
                onPressed: () {
                  context.read<SignInBloc>().add(
                        SignInButtonPressedeEvent(
                          emailController.text,
                          passController.text,
                        ),
                      );
                  print(state.toString());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("Sign In"),
              );
            },
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.viewInsetsOf(context).bottom)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    "New here?",
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<SignUpBloc>(context),
                            child: SignUpPage(
                              signUpBloc: SignUpBloc(
                                signInBloc.authRepository,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
