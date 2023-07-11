
// import 'package:bloc_cart_app/blocs/localization/localization_bloc.dart';
// import 'package:bloc_cart_app/blocs/localization/localization_event.dart';
// import 'package:bloc_cart_app/blocs/main/main_bloc.dart';
// import 'package:bloc_cart_app/blocs/signin/signin_bloc.dart';
// import 'package:bloc_cart_app/blocs/signup/signup_bloc.dart';
// import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
// import 'package:bloc_cart_app/commons/models/language_model.dart';
// import 'package:bloc_cart_app/features/auth/signin/sign_in_page.dart';
// import 'package:bloc_cart_app/features/auth/signup/sign_up_page.dart';
// import 'package:bloc_cart_app/localizations/localization_service.dart';
// import 'package:bloc_cart_app/obersver/bloc_observer.dart';
// import 'package:bloc_cart_app/repositories/authentication_repository.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
// import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
// import 'package:bloc_cart_app/commons/shared_prefs/my_shared_prefs.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';


// Future<void> main() async {
//   Bloc.observer = SimpleBlocObserver();
//   WidgetsFlutterBinding.ensureInitialized();
//   await SharedPrefs.initialize();
//   await GetStorage.init();
//   final authRepository = AuthenticationRepository();
//   runApp(MyApp(
//     authRepository: authRepository,
//   ));
// }

// class MyApp extends StatelessWidget {
//   final AuthenticationRepository authRepository;
//   const MyApp({
//     Key? key,
//     required this.authRepository,
//   }) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final localizationController = Get.put(LocalizationController());
//     bool isSignedIn = authRepository.getSignedInStatus(key: "isSignedUp");
//     final box = GetStorage();

//     return MultiRepositoryProvider(
//       providers: [
//         RepositoryProvider.value(
//           value: authRepository,
//         ),
//         RepositoryProvider(
//           create: (context) => LocalizationService(
//               locale: Locale(localizationController.currentLanguage)),
//         ),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           BlocProvider<LocalizationBloc>(
//             create: (context) =>
//                 LocalizationBloc(box)..add(LocalizationInitialEvent()),
//           ),
//           BlocProvider(create: (context) => MainBloc()),
//           BlocProvider(
//             create: (context) =>
//                 SignUpBloc(authRepository)..add(const SignUpInitialEvent()),
//           ),
//           BlocProvider(
//             create: (context) => HomeBloc()..add(const HomeInitialEvent()),
//           ),
//           BlocProvider(
//             create: (context) =>
//                 SignInBloc(authRepository)..add(const SignInInitialEvent()),
//           ),
//           BlocProvider(
//             create: (context) => CartBloc(),
//           ),
//           BlocProvider(
//             create: (context) => WishlistBloc(),
//           )
//         ],
//         child: BlocBuilder<LocalizationBloc, LocalizationState>(
//           builder: (context, state) {
//             return MaterialApp(
//               title: 'Flutter Demo',
//               debugShowCheckedModeBanner: false,
//               theme: ThemeData(
//                 primaryColor: Colors.blue.shade700,
//                 useMaterial3: true,
//               ),
//               locale: state is LocalizationLoadedState
//                   ? state.locale
//                   : LocalizationService.currentLocale,
//               localizationsDelegates: LocalizationService.localizationDelegates,
//               supportedLocales: LocalizationService.supportedLocales,
//               localeResolutionCallback:
//                   LocalizationService.localeResolutionCallBack,
//               home: isSignedIn ? const SignInPage() : const SignUpPage(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
