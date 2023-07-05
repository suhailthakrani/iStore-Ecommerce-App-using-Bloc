// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/blocs/signin/signin_bloc.dart';
import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/commons/shared_prefs/my_shared_prefs.dart';


import 'blocs/main/main_bloc.dart';
import 'blocs/signup/signup_bloc.dart';
import 'features/auth/sign_in_page.dart';
import 'features/auth/sign_up_page.dart';
import 'obersver/bloc_observer.dart';
import 'repositories/authentication_repository.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.setMockInitialValues({});
  await SharedPrefs.initialize();
  final authRepository = AuthenticationRepository();
  runApp(MyApp(
    authRepository: authRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authRepository;
  const MyApp({
    Key? key,
    required this.authRepository,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isSignedIn = authRepository.getSignedInStatus(key: "isSignedUp");
    return RepositoryProvider.value(
      value: authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>MainBloc()),
         
          BlocProvider(
            create: (context) =>
                SignUpBloc(authRepository)..add(const SignUpInitialEvent()),
          ),
          BlocProvider(
            create: (context) => HomeBloc()..add(const HomeInitialEvent()),
          ),
          BlocProvider(
            create: (context) => SignInBloc(authRepository)..add(const SignInInitialEvent()),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
           BlocProvider(
            create: (context) => WishlistBloc(),
          )

        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          
          theme: ThemeData(
            primaryColor: Colors.blue.shade700,
            useMaterial3: true,
          ),
          home: isSignedIn
              ? SignInPage(
                  signInBloc: SignInBloc(authRepository),
                )
              : SignUpPage(
                  signUpBloc: SignUpBloc(authRepository),
                ),
        ),
      ),
    );
  }
}
