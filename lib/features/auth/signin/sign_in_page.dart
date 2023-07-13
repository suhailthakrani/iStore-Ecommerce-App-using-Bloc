// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/features/home/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/blocs/signup/signup_bloc.dart';
import 'package:bloc_cart_app/commons/widgets/custom_text_field.dart';
import 'package:bloc_cart_app/features/auth/signup/sign_up_page.dart';
import 'package:bloc_cart_app/features/main/main_page.dart';

import '../../../blocs/main/main_bloc.dart';
import '../../../blocs/signin/signin_bloc.dart';
import '../../../localizations/localization_keys.dart';

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
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        SizedBox(
          height: 40,
          width: 120,
          child: Image.asset("assets/images/iStore.png"),
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Tkeys.welcomeBack.name,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor),
            ).tr(),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        CustomTextField(
          hint: Tkeys.enterEmail.name,
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
        const SizedBox(height: 20),
        BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            return CustomTextField(
                hint: Tkeys.enterPassword.name,
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
   
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
                "Forgor Password?",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
            ),
          ],
        ),
        
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
              child: Text(Tkeys.signIn.name).tr(),
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
                  Tkeys.newHere.name,
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
                          value: BlocProvider.of<SignUpBloc>(context),
                          child: const SignUpPage(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    Tkeys.signUp.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ).tr(),
                ),
              ],
            )
          ],
        ),
         const SizedBox(height: 12),
            const Row(
              children: [
                SizedBox(width: 12),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 5),
                Text("OR Continue with"),
                SizedBox(width: 5),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
        const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          padding: const EdgeInsets.all(8),
                            backgroundColor: Theme.of(context).primaryColor,  ),
                      icon: 
                      
                      Image.asset(
                        "assets/images/icons8-google-144.png",
                        height: 40,
                        width: 40,
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
                          padding: const EdgeInsets.all(8),
                          backgroundColor: Theme.of(context).primaryColor,  ),
                      icon: Image.asset(
                        "assets/images/icons8-facebook-144.png",
                        
                        height: 42,
                        width: 42,
                      ),
                      // icon: const Icon(Icons.facebook, color: Colors.white, size: 50,),
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
                          padding: const EdgeInsets.all(8),
                       ),
                      icon: Image.asset(
                        "assets/images/icons8-apple-logo-50.png",
                    color: Colors.white,
                        height: 42,
                        width: 42,
                      ),
                    );
                  },
                ),
              ],
            ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ],
    ));
  }
}
