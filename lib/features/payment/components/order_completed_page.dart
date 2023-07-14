import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/main/main_bloc.dart';
import 'package:bloc_cart_app/features/home/home_page.dart';
import 'package:bloc_cart_app/features/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCompletedPage extends StatelessWidget {
  // final String orderNumber;
  // final String productName;
  // final String productImage;

  const OrderCompletedPage({super.key, 
    // required this.orderNumber,
    // required this.productName,
    // required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(
       
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
             
              const SizedBox(height: 20),
              const Text(
                'Your order has been successfully created.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Order Number: orderNumber',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Product: productName',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  
                  context.read<CartBloc>().cartItems = [];
                  context.read<CartBloc>().totalItems = 0;
                  context.read<CartBloc>().totalPrice = 0;
                  context.read<MainBloc>().add(const MainTabChangeEvent(0));
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context) => const MainPage(),), (route) => false);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                child: const Text('Back to Home', style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
