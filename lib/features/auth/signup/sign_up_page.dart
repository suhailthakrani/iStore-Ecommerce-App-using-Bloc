// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc_cart_app/blocs/signin/signin_bloc.dart';
import 'package:bloc_cart_app/commons/widgets/translated_text.dart';
import 'package:bloc_cart_app/features/auth/signin/sign_in_page.dart';
import 'package:bloc_cart_app/features/auth/signup/components/language_widget.dart';

import 'package:bloc_cart_app/localizations/localization_service.dart';
import 'package:bloc_cart_app/repositories/auth_repo/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/commons/widgets/custom_text_field.dart';
import 'package:bloc_cart_app/commons/models/user_model.dart';
import 'package:get/get.dart';

import '../../../blocs/localization/localization_bloc.dart';
import '../../../blocs/localization/localization_event.dart';
import '../../../blocs/signup/signup_bloc.dart';
import '../../../localizations/localization_keys.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpBloc signUpBloc;
  late LocalizationBloc localizationBloc;

  bool showPass = false;
  bool showConfrimPass = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confrimPassController = TextEditingController();
  @override
  void initState() {
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    signUpBloc.add(const SignUpInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 25),
            SizedBox(
              height: 40,
              width: 100,
              child: Image.asset("assets/images/iStore.png"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Tkeys.createAccount.name,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                ).tr()
              ],
            ),
            const SizedBox(height: 20),
            const LanguageWidget(
              height: 60,
            ),
            const SizedBox(height: 50),
            CustomTextField(
              hint: Tkeys.enterName.name,
              controller: nameController,
              prefix: const Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
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
                          ? Text(
                              state.fieldErrors["name"] ?? "",
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
            CustomTextField(
              hint: Tkeys.enterEmail.name,
              controller: emailController,
              prefix: const Icon(
                Icons.email_outlined,
                color: Colors.white,
              ),
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
                          ? Text(
                              state.fieldErrors["email"] ?? "",
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
                    hint: Tkeys.enterPassword.name,
                    obsecure: showPass,
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
            const SizedBox(height: 5),
            BlocBuilder<SignUpBloc, SignUpState>(
              bloc: signUpBloc,
              builder: (context, state) {
                if (state is SignUpErrorState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fieldErrors["password"] != null
                          ? Text(state.fieldErrors["password"] ?? "",
                              style: const TextStyle(color: Colors.red))
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
                    hint: Tkeys.confirmPassword.name,
                    obsecure: showConfrimPass,
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
                    suffix: InkWell(
                      onTap: () {
                        showConfrimPass = !showConfrimPass;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: showConfrimPass
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                    ));
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
                          ? Text(
                              state.fieldErrors["confrimP"] ?? "",
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
            const SizedBox(height: 30),
            BlocConsumer<SignUpBloc, SignUpState>(
              listenWhen: (previous, current) =>
                  (current is SignUpNavigateState),
              listener: (context, state) {
                if (state is SignUpNavigateState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<SignInBloc>(context),
                        child: const SignInPage(),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    print(context.read<SignUpBloc>().state.toString());
                    AuthenticationRepository authenticationRepository =
                        AuthenticationRepository();
                    authenticationRepository.setSignedInStatus(
                        key: "isSignedUp", value: true);
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
                      foregroundColor: Colors.white),
                  child: Text(Tkeys.signUp.name).tr(),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      Tkeys.alreadyHaveAnAccount.name,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ).tr(),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: BlocProvider.of<SignInBloc>(context),
                              child: const SignInPage(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        Tkeys.signIn.name,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                        ),
                      ).tr(),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 12),
             Row(
              children: [
                const SizedBox(width: 12),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 5),
                Text(Tkeys.orContinueWith.name).tr(),
                const SizedBox(width: 5),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<SignUpBloc, SignUpState>(
                  listenWhen: (previous, current) =>
                      (current is SignUpNavigateState),
                  listener: (context, state) {
                    if (state is SignUpNavigateState) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<SignInBloc>(context),
                            child: const SignInPage(),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        print(context.read<SignUpBloc>().state.toString());
                        AuthenticationRepository authenticationRepository =
                            AuthenticationRepository();
                        authenticationRepository.setSignedInStatus(
                            key: "isSignedUp", value: true);
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
                          elevation: 10,
                          padding: const EdgeInsets.all(8),
                               backgroundColor: Theme.of(context).primaryColor, ),
                      icon: Image.asset(
                        "assets/images/icons8-google-144.png",
                        height: 40,
                        width: 40,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 20),
                BlocConsumer<SignUpBloc, SignUpState>(
                  listenWhen: (previous, current) =>
                      (current is SignUpNavigateState),
                  listener: (context, state) {
                    if (state is SignUpNavigateState) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<SignInBloc>(context),
                            child: const SignInPage(),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        print(context.read<SignUpBloc>().state.toString());
                        AuthenticationRepository authenticationRepository =
                            AuthenticationRepository();
                        authenticationRepository.setSignedInStatus(
                            key: "isSignedUp", value: true);
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
                          elevation: 10,
                          padding: const EdgeInsets.all(8),
                              backgroundColor: Theme.of(context).primaryColor, ),
                      icon: Image.asset(
                        "assets/images/icons8-facebook-144.png",
                        height: 42,
                        width: 42,
                      ),
                    );
                  },
                ),
                 const SizedBox(width: 20),
                BlocConsumer<SignInBloc, SignInState>(
                  listenWhen: (previous, current) =>
                      (current is SignInNavigateState),
                  listener: (context, state) {
                    if (state is SignInNavigateState) {
                     // Navigate to HomePage
                    }
                  },
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                     
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.all(10),
                       ),
                      icon: Image.asset(
                        "assets/images/icons8-apple-logo-50.png",
                    color: Colors.white,
                        height: 38,
                        width: 38,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
