// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/commons/widgets/custom_text_field.dart';
import 'package:bloc_cart_app/models/user_model.dart';

import '../../blocs/signup/signup_bloc.dart';
import '../cart/cart_page.dart';

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
            const SizedBox(height: 40),
            CustomTextField(
              hint: "Enter your name",
              controller: nameController,
              prefix: const Icon(Icons.person_outline),
              onChanged: (val) {},
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
                          ? Text(state.fieldErrors["name"] ?? "")
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
              prefix: const Icon(Icons.email_outlined),
              onChanged: (val) {},
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
                          ? Text(state.fieldErrors["email"] ?? "")
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
              prefix: const Icon(Icons.lock_outline),
              onChanged: (val) {},
            ),
            const SizedBox(height: 5),
            BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              builder: (context, state) {
                if (state is SignUpErrorState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fieldErrors["password"] != null
                          ? Text(state.fieldErrors["password"] ?? "")
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
              hint: "Confirm password",
              controller: confrimPassController,
              prefix: const Icon(Icons.lock_outline),
              onChanged: (val) {},
            ),
            const SizedBox(height: 5),
            BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              builder: (context, state) {
                if (state is SignUpErrorState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fieldErrors["password"] != null
                          ? Text(state.fieldErrors["password"] ?? "")
                          : Container(),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 30),
            BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is !SignUpErrorState) {
                    Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<HomeBloc>(context),
                  child:  const HomePage(),
                ),
              ),
            );
                }
              },
              child: ElevatedButton(
                onPressed: () {
                  context.read<SignUpBloc>().add(
                        SignUpButtonPressedEvent(
                          UserModel(
                            email: emailController.text,
                            name: nameController.text,
                            password: passController.text,
                          ),
                        ),
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
