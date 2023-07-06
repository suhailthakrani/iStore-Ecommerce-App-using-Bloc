import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
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

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  List<String> imagePaths = [
    'assets/images/mac.jpg',
    'assets/images/sony.jpg',
    'assets/images/mac.jpg',
  ];

  @override
  void initState() {
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
      body: SingleChildScrollView(
        
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<HomeBloc, HomeState>(
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Top Suggestions for You!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.blue.shade900),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: ImageSlider(
                              imagePaths: imagePaths,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Trending",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const Text(
                          "Discount Offers",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Text(
                          "Recommended",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: loadedState.products.length,
                      itemBuilder: (context, index) {
                        final product = loadedState.products[index];
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
                                      builder: (context) => ProductDetails(
                                        product: product,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                        product.image,
                                      ), // Replace with your image path
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
                                        style: const TextStyle(
                                          color: Colors.black54,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$ ${product.price}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Wrap(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  context.read<HomeBloc>().add(
                                                      HomeAddToWishlistEvent(
                                                          product, context));
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          "${product.name} added to the wishlist"),
                                                    ),
                                                  );
                                                },
                                                style: IconButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                icon: context
                                                        .read<WishlistBloc>()
                                                        .wishlistItems
                                                        .contains(product)
                                                    ? Icon(
                                                        CupertinoIcons
                                                            .heart_fill,
                                                        color: Colors
                                                            .yellow.shade700,
                                                      )
                                                    : const Icon(
                                                        CupertinoIcons.heart),
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
                                                  style: IconButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(20),
                                                    ),
                                                  ),
                                                  icon: context
                                                          .read<CartBloc>()
                                                          .cartItems
                                                          .contains(product)
                                                      ? const Icon(Icons.done)
                                                      : const Icon(
                                                          CupertinoIcons
                                                              .cart))
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
                    ),
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
      ),
    );
  }
}
