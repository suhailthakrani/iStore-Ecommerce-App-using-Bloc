import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/wishlist/wishlist_bloc.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
    late WishlistBloc wishlistBloc;
  @override
  void initState() {
    final wishlistBloc = BlocProvider.of<WishlistBloc>(context);
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
        title: const Text(
          "Your Wish List",
          
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
         listener: (context, state) {
          if (state is WishlistInitialState) {
            context.read<WishlistBloc>().add(WishlistInitialEvent());
          }
        },
        builder: (context, state) {
          print(state.toString());
          if (state is WishlistLoadedState) {
            final loadedState = state;
            if (loadedState.wishlistItems.isNotEmpty) {
              
        
            return ListView.builder(
                itemCount: loadedState.wishlistItems.length,
                itemBuilder: (context, index) {
                  final product = loadedState.wishlistItems[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Image(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                            image: AssetImage(
                              product.image,
                            ), // Replace with your image path
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
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
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8)),
                                    onPressed: () {
                                      context.read<WishlistBloc>().add(
                                          WishlistRemoveItemEvent(product));
                                    },
                                    child: const Text("Remove"),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                            CartAddItemEvent(product: product),
                                          );
                                    },
                                    child: const Icon(CupertinoIcons.cart),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          
            } else {
          
              return  Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                     const Icon(CupertinoIcons.bag, size: 70, color: Colors.black45,),
                      const SizedBox(height: 20),
                    const Text(
                      "Your Wishlist is Empty!",
                      style: TextStyle(color: Colors.black45, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                
                  ],
                ),
              );
           
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.bag,
                    size: 70,
                    color: Colors.black45,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "You have an Empty Wishlist!",
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.051),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
