import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/blocs/payment/payment_bloc.dart';
import 'package:bloc_cart_app/features/payment/payment_page.dart';
import 'package:bloc_cart_app/repositories/payment_repo/payment_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localizations/localization_keys.dart';

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
      // backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Tkeys.yourCart.name,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ).tr(),
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
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.15),
                itemCount: loadedState.cartItems.length,
                itemBuilder: (context, index) {
                  final product = loadedState.cartItems[index];
                  double price = double.parse(product.price) * product.quantity;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    // margin: const EdgeInsets.only(bottom: 16),
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
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(3, 3),
                                  )
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                                image: AssetImage(
                                  product.image,
                                ), // Replace with your image path
                              ),
                            ),
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
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              //  Text(
                              //       product.description,
                              //       maxLines: 2,
                              //       overflow: TextOverflow.ellipsis,
                              //       style: const TextStyle(
                              //         color: Colors.black45,
                              //         fontSize: 11,
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //     ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  state is CartItemQuantityChangedState
                                      ? Text(
                                          "\$ $price",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Text(
                                          "\$ $price",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
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
                                      padding: EdgeInsets.zero,
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
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : Text(
                                          "${product.quantity}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: IconButton.styleFrom(
                                      padding: EdgeInsets.zero,
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
                    Text(
                     Tkeys.emptyCart.name ,
                      style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ).tr(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  ],
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
      bottomSheet: SizedBox(
        height: 120,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Tkeys.totalItems.name,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ).tr(),
                      Text(
                        "${cartBloc.cartItems.fold(cartBloc.totalCartItems, (previousValue, element) => previousValue + element.quantity).toInt()}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Tkeys.totalPrice.name,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ).tr(),
                      Text(
                        "\$ ${cartBloc.totalPrice}",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final paymentRepository = PaymentRepository();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RepositoryProvider<PaymentRepository>.value(
                              value: paymentRepository,
                              child: BlocProvider<PaymentBloc>(
                                create: (context) =>
                                    PaymentBloc(paymentRepository),
                                child: const PaymentPage(),
                              ),
                            ),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12)),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Tkeys.checkOut.name,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ).tr(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
