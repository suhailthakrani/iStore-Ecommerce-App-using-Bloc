import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context)
      ..add(const HomeInitialEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
                context.read<HomeBloc>().add(HomeNavigateToCartEvent());
            },
            icon: const Icon(
              CupertinoIcons.cart,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
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
                  final product = loadedState.products[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 3),
                          color: Colors.grey.shade400,
                        ),
                         BoxShadow(
                          offset: const Offset(3, 0),
                          color: Colors.grey.shade400,
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const FlutterLogo(size: 30),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Product ${product.name} ${index}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Rs ${product.price}"),
                                  Text("Product ${product.price}"),
                                ],
                              ),
                              ElevatedButton(onPressed: (){}, child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Text("Add to cart"),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () {
                                    
                                    },
                                    icon: const Icon(CupertinoIcons.cart),
                                  ),
                                ],
                              ))
                            ],
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
              return SizedBox();
          }
        },
        listener: (context, state) {
          if (state is HomeNavigateToCartState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
