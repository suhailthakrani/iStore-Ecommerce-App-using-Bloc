import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cart_page.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(const HomeInitialEvent());

    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 27, 25, 18),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 11, 8),
        title: const Text(
          "Home Page",
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(HomeNavigateToCartEvent());
              },
              style: IconButton.styleFrom(
                  backgroundColor: const Color(0xff1B1811),
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.yellow.shade900,
                      ),),),
              child: const Icon(CupertinoIcons.cart)),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          print(state.toString());
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case HomeLoadedState:
              final loadedState = state as HomeLoadedState;
              return ListView.builder(
                itemCount: loadedState.products.length,
                itemBuilder: (context, index) {
                  print(state.products);
                  final product = loadedState.products[index];
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(-3, 3),
                          color: Color(0xff1B1811),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.width * 0.3,
                              fit: BoxFit.contain,
                              image: AssetImage(
                                product.image,
                              ), // Replace with your image path
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white60,
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
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<HomeBloc>().add(
                                            HomeAddToCartEvent(
                                                product, context));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "${product.name} added to the cart"),
                                          ),
                                        );
                                      },
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          padding: const EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                color: Colors.yellow.shade900,
                                              ),),),
                                      child: const Icon(CupertinoIcons.cart),
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
}
