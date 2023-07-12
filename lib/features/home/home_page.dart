import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:bloc_cart_app/commons/constants/constants.dart';
import 'package:bloc_cart_app/features/home/components/product_list.dart';
import 'package:bloc_cart_app/features/home/product/components/image_slider.dart';
import 'package:bloc_cart_app/features/home/product/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomeBloc homeBloc;
  List<String> imagePaths = [
    'assets/images/mac.jpg',
    'assets/images/sony.jpg',
    'assets/images/mac.jpg',
  ];
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(const HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 160,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            "assets/images/iStore.png",
            height: 50,
            width: 80,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black54,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
            icon: const Icon(
              Icons.notifications_outlined,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeLoadedState:
              final loadedState = state as HomeLoadedState;
              return Column(
                children: [
                  // Container(
                  //   margin: const EdgeInsets.only(top: 10),
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 150,
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Expanded(
                  //         child: ImageSlider(
                  //           imagePaths: imagePaths,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TabBar(
                        labelColor: Colors.white,
                        dividerColor: Colors.white,
                        isScrollable: true,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        controller: tabController,
                        padding: EdgeInsets.zero,
                        indicatorPadding:
                            const EdgeInsets.symmetric(vertical: 11.5),
                        labelPadding: const EdgeInsets.only(right: 5, left: 5),
                        tabs: [
                          customTab(AppConstants.airbods),
                          customTab(AppConstants.appwatches),
                          customTab(AppConstants.casesAndProtection),
                          customTab(AppConstants.airTagAndAccessories),
                          customTab(AppConstants.keyboards),
                          customTab(AppConstants.miceAndTrackpads),
                          customTab(AppConstants.powerAndCables),
                          customTab(AppConstants.iphone),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(controller: tabController, children: [
                      ProductList(
                          category: loadedState.products
                              .getProductsByCategory(AppConstants.airbods)!),
                      ProductList(
                          category: loadedState.products
                              .getProductsByCategory(AppConstants.appwatches)!),
                      ProductList(
                          category: loadedState.products.getProductsByCategory(
                              AppConstants.casesAndProtection)!),
                      ProductList(
                          category: loadedState.products.getProductsByCategory(
                              AppConstants.airTagAndAccessories)!),
                      ProductList(
                          category: loadedState.products
                              .getProductsByCategory(AppConstants.keyboards)!),
                      ProductList(
                          category: loadedState.products.getProductsByCategory(
                              AppConstants.miceAndTrackpads)!),
                      ProductList(
                          category: loadedState.products.getProductsByCategory(
                              AppConstants.powerAndCables)!),
                      ProductList(
                          category: loadedState.products
                              .getProductsByCategory(AppConstants.iphone)!),
                    ]),
                  )
                ],
              );
            case HomeErrorState:
              return const Center(
                child: Text("Ups! Something went wrong!"),
              );

            default:
              return const Center(
                child: Text("No Products!"),
              );
          }
        },
        listener: (context, state) {
          if (state is HomeInitialState) {
            context.read<HomeBloc>().add(const HomeInitialEvent());
          }
          if (state is HomeNavigateToCartState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: BlocProvider.of<CartBloc>(context),
                  child: const CartPage(),
                ),
              ),
            );
          } else if (state is HomeItemAddedToCartState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.product.name} added to the cart"),
              ),
            );
          }
        },
      ),
    );
  }

  Tab customTab(String title) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
