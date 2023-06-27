import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartBloc cartBloc;
  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  const Color.fromARGB(255, 27, 25, 18),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 11, 8),
        leading: IconButton(
          onPressed: () {
            final homeBloc = BlocProvider.of<HomeBloc>(context);
            homeBloc.add(const HomeInitialEvent());
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Cart Page",  style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        // listenWhen: (previous, current) => current != previous,
        listener: (context, state) {
          if (state is CartInitialState) {
            context.read<CartBloc>().add(CartInitialEvent());
          }
        },
        // Use BlocBuilder to rebuild the widget based on CartState changes
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoadedState) {
            final loadedState = state;
            if (loadedState.cartItems.isNotEmpty) {
              return ListView.builder(
                itemCount: loadedState.cartItems.length,
                itemBuilder: (context, index) {
                  final product = loadedState.cartItems[index];
                  double price = double.parse(product.price) * product.quantity;
                  return Container(
                    padding: const EdgeInsets.all(16),
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
                        Image(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          image: AssetImage(
                            product.image,
                          ), // Replace with your image path
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.name}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  state is CartItemQuantityChangedState
                                      ? Text(
                                          "\$ $price",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white60,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Text(
                                          "\$ $price",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white60,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: const EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: Colors.yellow.shade900,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                          CartRemoveItemEvent(
                                              product: product));
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                  const SizedBox(width: 10),
                                  state is CartItemQuantityChangedState
                                      ? Text(
                                          "${product.quantity}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Text(
                                          "${product.quantity}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: const EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: Colors.yellow.shade900,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                          CartAddItemEvent(product: product));
                                    },
                                    child: const Icon(CupertinoIcons.add),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "Your Cart is Empty!",
                  style: TextStyle(color: Colors.white70, fontSize: 24),
                ),
              );
            }
          } else if (state is HomeErrorState) {
            return const Center(
              child: Text("Ups! Something went wrong!"),
            );
          } else {
            return const Center(
              child: Text(
                "Your Cart is Empty!",
                style: TextStyle(color: Colors.white70, fontSize: 24),
              ),
            );
          }
        },
      ),
    );
  }
}
