// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/blocs/signup/signup_bloc.dart';
import 'package:bloc_cart_app/features/auth/sign_up_page.dart';
import 'package:bloc_cart_app/features/main/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/commons/widgets/custom_text_field.dart';

import '../../blocs/main/main_bloc.dart';
import '../../blocs/signin/signin_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInBloc signInBloc;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool showPass = false;

  @override
  void initState() {
    signInBloc = BlocProvider.of<SignInBloc>(context);
    signInBloc.add(const SignInInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Back",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "S I G N I N  H E R E !",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset("assets/images/ecommerc.png"),
          ),
        ),
        const SizedBox(height: 60),
        CustomTextField(
          hint: "Enter your email",
          controller: emailController,
          prefix: const Icon(
            Icons.email_outlined,
            color: Colors.white,
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
            if (state is SignInErrorState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.errors["email"] != null
                      ? Text(
                          " * ${state.errors["email"]}",
                          style: const TextStyle(color: Colors.red),
                        )
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
                obsecure: !showPass,
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
                  Icons.lock_outline,
                  color: Colors.white,
                ),
                suffix: InkWell(
                  onTap: () {
                    showPass = !showPass;
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: showPass
                        ? const Icon(CupertinoIcons.eye)
                        : const Icon(CupertinoIcons.eye_slash),
                  ),
                ));
          },
        ),
        BlocBuilder<SignInBloc, SignInState>(
          bloc: signInBloc,
          builder: (context, state) {
            if (state is SignInErrorState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.errors["password"] != null
                      ? Text(
                          " * ${state.errors["password"]}",
                          style: const TextStyle(color: Colors.red),
                        )
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
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is SignInNavigateState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: BlocProvider.of<MainBloc>(context),
                    child: const MainPage(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
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
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white),
              child: const Text("Sign In"),
            );
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  "New here?",
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
                          value: BlocProvider.of<SignUpBloc>(context),
                          child: const SignUpPage(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
       SizedBox(height: MediaQuery.of(context).viewInsets.bottom,),
      ],
    ));
  }
}
