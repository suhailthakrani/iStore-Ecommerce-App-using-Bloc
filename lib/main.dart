// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/features/main/main_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/blocs/signin/signin_bloc.dart';
import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:bloc_cart_app/commons/storage/my_shared_prefs.dart';
import 'package:bloc_cart_app/repositories/product_repo/products_repository.dart';

import 'blocs/main/main_bloc.dart';
import 'blocs/signup/signup_bloc.dart';
import 'features/auth/signin/sign_in_page.dart';
import 'features/auth/signup/sign_up_page.dart';
import 'obersver/bloc_observer.dart';
import 'repositories/auth_repo/authentication_repository.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initialize();
  await EasyLocalization.ensureInitialized();

  final authRepository = AuthenticationRepository();
  final  productsRepository  = ProductsRepository();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en', ''),
      Locale('hi', ''),
      Locale('es', ''),
      Locale('de', ''),
      Locale('ur', ''),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('en', ''),
    startLocale: const Locale('en', ''),
    saveLocale: true,
    useOnlyLangCode: true,
    child: MyApp(
      authRepository: authRepository,
      productsRepository: productsRepository,
    ),
  ));
  // runApp(MyApp(
  //   authRepository: authRepository,
  // ));
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository authRepository;
  final ProductsRepository productsRepository;  
  const MyApp({
    Key? key,
    required this.authRepository,
    required this.productsRepository,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isSignedIn = authRepository.getSignedInStatus(key: "isSignedUp");

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authRepository,
        ),
          RepositoryProvider.value(
          value: productsRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => LocalizationBloc(
          //       box: box, localizationService: localizationService),
          // ),
          BlocProvider(create: (context) => MainBloc()),
          BlocProvider(
            create: (context) =>
                SignUpBloc(authRepository)..add(const SignUpInitialEvent()),
          ),
          BlocProvider(
            create: (context) => HomeBloc(productsRepository: productsRepository)..add(const HomeInitialEvent()),
          ),
          BlocProvider(
            create: (context) =>
                SignInBloc(authRepository)..add(const SignInInitialEvent()),
          ),
          BlocProvider(
            create: (context) => CartBloc(),
          ),
          BlocProvider(
            create: (context) => WishlistBloc(),
          )
        ],
        child: MaterialApp(
          title: 'E Commerce App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color(0xff343434),
            useMaterial3: true,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: isSignedIn ? const SignInPage() : const SignUpPage(),
        ),
      ),
    );
  }
}
