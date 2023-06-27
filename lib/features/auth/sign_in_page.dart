// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/commons/widgets/custom_text_field.dart';

import '../../blocs/signin/signin_bloc.dart';

class SignInPage extends StatelessWidget {
  final SignInBloc signInBloc;
  const SignInPage({
    Key? key,
    required this.signInBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          //
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 40),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "S I G N I N  H E R E !",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const FlutterLogo(
                  size: 50,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  hint: "Enter your email",
                  controller: emailController,
                  prefix: const Icon(
                    Icons.email_outlined,
                  ),
                  onChanged: (pass) {
              // signInBloc.add(SignIn(
              //   UserModel(
              //     email: emailController.text,
              //     name: nameController.text,
              //     password: pass,
              //   ),
              // ));
            },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: "Enter password",
                  controller: passController,
                   onChanged: (pass) {
              // signInBloc.add(SignIn(
              //   UserModel(
              //     email: emailController.text,
              //     name: nameController.text,
              //     password: pass,
              //   ),
              // ));
            },
                  prefix: Icon(
                    Icons.person_outline,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade800,
                  ),
                  child: const Text("Sign In"),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.viewInsetsOf(context).bottom)),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
