// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/blocs/signin/signin_bloc.dart';
import 'package:bloc_cart_app/features/auth/sign_in_page.dart';
import 'package:bloc_cart_app/features/home/home_page.dart';
import 'package:bloc_cart_app/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/commons/widgets/custom_text_field.dart';
import 'package:bloc_cart_app/models/user_model.dart';

import '../../blocs/signup/signup_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpBloc signUpBloc;
  

  SignUpPage({
    Key? key,
    required this.signUpBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    final TextEditingController confrimPassController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "S I G N U P  H E R E !",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
               Container(
                height: 150,
                width: 150,
                padding: const EdgeInsets.all(20),
                child: Image.asset("assets/images/ecommerc.png"),
            
            ),
            const SizedBox(height: 40),
            CustomTextField(
              hint: "Enter your name",
              controller: nameController,
              prefix: const Icon(Icons.person_outline, color: Colors.white,),
              onChanged: (val) {
                context.read<SignUpBloc>().add(
                      SignUpTextFieldsChangedEvent(
                        UserModel(
                          email: emailController.text,
                          name: val,
                          password: passController.text,
                          confrimP: confrimPassController.text,
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 5),
            BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              builder: (context, state) {
                if (state is SignUpErrorState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fieldErrors["name"] != null
                          ? Text(state.fieldErrors["name"] ?? "", style: TextStyle(color: Colors.red),)
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
              hint: "Enter your email",
              controller: emailController,
              prefix: const Icon(Icons.email_outlined, color: Colors.white,),
              onChanged: (val) {
                context.read<SignUpBloc>().add(
                      SignUpTextFieldsChangedEvent(
                        UserModel(
                          email: emailController.text,
                          name: nameController.text,
                          password: passController.text,
                          confrimP: confrimPassController.text,
                        ),
                      ),
                    );
              },
            ),
            const SizedBox(height: 5),
            BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              builder: (context, state) {
                if (state is SignUpErrorState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fieldErrors["email"] != null
                          ? Text(state.fieldErrors["email"] ?? "", style: TextStyle(color: Colors.red), )
                          : Container(),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return CustomTextField(
                hint: "Enter password",
                obsecure: signUpBloc.showPass,
                controller: passController,
                onChanged: (pass) {
                 context.read<SignUpBloc>().add(
                      SignUpTextFieldsChangedEvent(
                        UserModel(
                          email: emailController.text,
                          name: nameController.text,
                          password: pass,
                          confrimP: confrimPassController.text,
                        ),
                      ),
                    );
                },
                prefix: const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                suffix:InkWell(
                      onTap: () {
                      
                        signUpBloc.showPass = !signUpBloc.showPass;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: signUpBloc.showPass
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                    )
              );
            },
          ), const SizedBox(height: 5),
            BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              builder: (context, state) {

                if (state is SignUpErrorState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fieldErrors["password"] != null
                          ? Text(state.fieldErrors["password"] ?? "", style: const TextStyle(color: Colors.red))
                          : Container(),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 10),
             BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return CustomTextField(
                hint: "Confirm password",
                obsecure: signUpBloc.showPass,
                controller: confrimPassController,
                onChanged: (pass) {
                 context.read<SignUpBloc>().add(
                      SignUpTextFieldsChangedEvent(
                        UserModel(
                          email: emailController.text,
                          name: nameController.text,
                          password: pass,
                          confrimP: confrimPassController.text,
                        ),
                      ),
                    );
                },
                prefix: const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                suffix:InkWell(
                      onTap: () {
                      
                        signUpBloc.showPass = !signUpBloc.showPass;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: signUpBloc.showPass
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                    )
              );
            },
          ),
           
            const SizedBox(height: 5),
            BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              builder: (context, state) {
                if (state is SignUpErrorState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fieldErrors["confrimP"] != null
                          ? Text(state.fieldErrors["confrimP"] ?? "", style: TextStyle(color: Colors.red),)
                          : Container(),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 30),
            BlocConsumer<SignUpBloc, SignUpState>(
              listenWhen: (previous, current) =>
                  (current is SignUpNavigateState),
              listener: (context, state) {
                if (state is SignUpNavigateState) {
                  AuthenticationRepository authenticationRepository =
                      AuthenticationRepository();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<SignInBloc>(context),
                        child: SignInPage(
                          signInBloc: SignInBloc(authenticationRepository),
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    print(context.read<SignUpBloc>().state.toString());
                    AuthenticationRepository authenticationRepository = AuthenticationRepository();
                    authenticationRepository.setSignedInStatus(key: "isSignedUp", value: true);
                    context.read<SignUpBloc>().add(
                          SignUpButtonPressedEvent(
                            UserModel(
                              email: emailController.text,
                              name: nameController.text,
                              password: passController.text,
                              confrimP: confrimPassController.text,
                            ),
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white
                  ),
                  child: const Text("Sign Up"),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      "Alrady member?",
                       style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: BlocProvider.of<SignInBloc>(context),
                              child: SignInPage(
                                signInBloc: SignInBloc(
                                  AuthenticationRepository(),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
