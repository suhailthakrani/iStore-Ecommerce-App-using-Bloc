import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/blocs/signin/signin_bloc.dart';
import 'package:bloc_cart_app/features/auth/sign_in_page.dart';
import 'package:bloc_cart_app/features/home/product/product_details_page.dart';
import 'package:bloc_cart_app/repositories/authentication_repository.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 0,
        
        title: Image.asset("assets/images/ecommerc.png",height: 65, width: 80,),
        
        // Text(
        //   "E Commerce",
        //   style: TextStyle(
        //     color: Theme.of(context).primaryColor,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(HomeNavigateToCartEvent());
            },
            style: IconButton.styleFrom(
              
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: Colors.yellow.shade900,
                ),
              ),
            ),
            child: const Icon(CupertinoIcons.cart),
          ),
          BlocListener<HomeBloc, HomeState>(
            listener:(context, state) {
              if (state is HomeLogoutState) {
                AuthenticationRepository authRepository = AuthenticationRepository();
                 Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: BlocProvider.of<SignInBloc>(context),
                        child: SignInPage(signInBloc: SignInBloc(authRepository),),
                      ),
                    ),
                  );
              }
            },
            child:  PopupMenuButton(
              color: Theme.of(context).primaryColor,
              shadowColor: Colors.white,
                onOpened: () {
                  // context.read<HomeBloc>().add(HomeMoreMenuButtonPressedEvent());
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        context
                            .read<HomeBloc>()
                            .add(HomeLogoutButtonPressedEvent());
                      },
                      child: const Text("Logout"),
                    )
                  ];
                } 
            ),
            
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<HomeBloc, HomeState>(
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
                          const EdgeInsets.only( bottom: 16),
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
                        builder: (context) =>  ProductDetails(product: product,),
                        
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
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.width * 0.3,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:  const TextStyle(
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
                                          
                                          padding: const EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                              color: Colors.yellow.shade900,
                                            ),
                                          ),
                                        ),
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
      ),
    );
  }
}
