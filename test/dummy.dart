
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
// ==============================================================
// import 'package:bloc_cart_app/commons/models/categories.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../blocs/home/home_bloc.dart';
// import 'components/search_deligate.dart';

// class CategoriesPage extends StatelessWidget {
//   const CategoriesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeBloc, HomeState>(
//       builder: (context, state) {
//         if (state is HomeLoadedState) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text(
//                 'Product Categories',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18,
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     showSearch(
//                       context: context,
//                       delegate: ProductSearchDelegate(products: state.products),
//                     );
//                   },
//                   icon: const Icon(Icons.search),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: const Icon(CupertinoIcons.slider_horizontal_3),
//                 ),
//                 const SizedBox(width: 20),
//               ],
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: GridView.count(
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.all(30),
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 20,
//                     mainAxisSpacing: 20,
//                     children: List.generate(
//                       Categories.categories.length,
//                       (index) => Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.shade300,
//                                 offset: const Offset(3, 3),
//                               )
//                             ]),
//                         padding: const EdgeInsets.all(8),
//                         child: Column(
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image(
//                                 width: MediaQuery.of(context).size.width * 0.28,
//                                 height:
//                                     MediaQuery.of(context).size.width * 0.28,
//                                 image: AssetImage(
//                                   Categories.categories[index].image,
//                                 ), // Replace with your image path
//                               ),
//                             ),
//                             Expanded(
//                                 child: Text(
//                               Categories.categories[index].name,
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: Theme.of(context).primaryColor
//                               ),
//                             ))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return const Center(
//             child: Text("Category"),
//           );
//         }
//       },
//     );
//   }
// }


import 'package:bloc_cart_app/commons/models/categories.dart';
import 'package:bloc_cart_app/commons/models/product_categories.dart';
import 'package:bloc_cart_app/features/categories/components/filter_page.dart';
import 'package:bloc_cart_app/features/categories/components/test_p.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../blocs/wishlist/wishlist_bloc.dart';
import '../home/product/product_details_page.dart';
import 'components/search_deligate.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadedState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Product Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ProductSearchDelegate(products: state.products),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: CustomScrollView(
              slivers: [

                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder:(context) => TextP(),));
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4)),
                          icon: const Icon(Icons.sort),
                          label: const Text("Sort"),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4)),
                          icon: const Icon(Icons.filter_alt_outlined),
                          label: const Text("Filter"),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4)),
                          icon: const Icon(Icons.format_line_spacing_outlined),
                          label: const Text("All Categories"),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverAnimatedList(
                    initialItemCount: state.products.products.length,
                    itemBuilder: (context, index, animation) {
                      final name = state.products.products[index].category;
                      final List<CategoryProduct> categoryProducts =
                          state.products.products[index].categoryProducts;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categoryProducts.length,
                            itemBuilder: (context, categoryIndex) {
                              final product = categoryProducts[categoryIndex];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetails(
                                              product: product,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300,
                                                  offset: const Offset(3, 3),
                                                )
                                              ]),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              fit: BoxFit.contain,
                                              image: AssetImage(
                                                product.image,
                                              ),
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                              ), // Replace with your image path
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              product.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.black45,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "\$ ${product.price}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Wrap(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<HomeBloc>()
                                                            .add(
                                                                HomeAddToWishlistEvent(
                                                                    product,
                                                                    context));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                                "${product.name} added to the wishlist"),
                                                          ),
                                                        );
                                                      },
                                                      style:
                                                          IconButton.styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                      ),
                                                      icon: context
                                                              .read<
                                                                  WishlistBloc>()
                                                              .wishlistItems
                                                              .contains(product)
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .heart_fill,
                                                              color: Colors
                                                                  .yellow
                                                                  .shade700,
                                                            )
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .heart,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                            ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          context
                                                              .read<HomeBloc>()
                                                              .add(
                                                                  HomeAddToCartEvent(
                                                                      product,
                                                                      context));

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  "${product.name} added to the cart"),
                                                            ),
                                                          );
                                                        },
                                                        style: IconButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                        ),
                                                        icon: context
                                                                .read<
                                                                    CartBloc>()
                                                                .cartItems
                                                                .contains(
                                                                    product)
                                                            ? const Icon(
                                                                Icons.done)
                                                            : Icon(
                                                                CupertinoIcons
                                                                    .cart,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ))
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Category"),
          );
        }
      },
    );
  }
}
// Column(
//                   children: [
//                     Expanded(
//                       child: GridView.count(
//                         shrinkWrap: true,
//                         padding: const EdgeInsets.all(30),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 20,
//                         mainAxisSpacing: 20,
//                         children: List.generate(
//                           Categories.categories.length,
//                           (index) => Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.shade300,
//                                     offset: const Offset(3, 3),
//                                   )
//                                 ]),
//                             padding: const EdgeInsets.all(8),
//                             child: Column(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Image(
//                                     width: MediaQuery.of(context).size.width * 0.28,
//                                     height:
//                                         MediaQuery.of(context).size.width * 0.28,
//                                     image: AssetImage(
//                                       Categories.categories[index].image,
//                                     ), // Replace with your image path
//                                   ),
//                                 ),
//                                 Expanded(
//                                     child: Text(
//                                   Categories.categories[index].name,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: Theme.of(context).primaryColor
//                                   ),
//                                 ))
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),