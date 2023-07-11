import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
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
    tabController = TabController(length: 6, vsync: this);
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
        leadingWidth: 80,
        leading: Image.asset(
          "assets/images/ecommerc.png",
          height: 65,
          width: 80,
        ),
        title: Text(
          "Your E Commerce App",
          style: TextStyle(
            fontSize: 17,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blueGrey.shade100,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
            icon: Icon(
              Icons.notifications_outlined,
              size: 30,
              color: Colors.blue.shade900,
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
                        dividerColor: Colors.white,
                        isScrollable: true,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16)),
                        controller: tabController,
                        padding: EdgeInsets.zero,
                        indicatorPadding:
                            const EdgeInsets.symmetric(vertical: 11.5),
                            labelPadding: const EdgeInsets.only(right: 5,left: 5),
                        tabs: [
                          customTab("Trending"),
                          customTab("Recommended"),
                          customTab("Sepcial Diccount Offers"),
                          customTab("Loot Lo!"),
                          customTab("Flash Sale"),
                          customTab("Super Deals"),
                        ]),
                  ),
                  Expanded(
                    child: TabBarView(controller: tabController, children: [
                      ProductList(products: loadedState.products),
                      ProductList(products: loadedState.recommended),
                      ProductList(products: loadedState.sepcialDiccountOffers),
                      ProductList(products: loadedState.lootLo),
                      ProductList(products: loadedState.flashSale),
                      ProductList(products: loadedState.superDeals),
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
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
