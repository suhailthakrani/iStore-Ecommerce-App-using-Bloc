// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/blocs/home/home_bloc.dart';
import 'package:bloc_cart_app/commons/models/product_categories.dart';
import 'package:bloc_cart_app/features/home/product/components/see_more.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../commons/models/product.dart';

class ProductDetails extends StatelessWidget {
  final CategoryProduct product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appleColors = [
      0xff808080, // Space Gray
      0xffC0C0C0, // Silver
      0xffFFD700, // Gold
      0xffFFC0CB, // Rose Gold
      0xff004953, // Midnight Green
      0xff007AFF, // Blue
      0xffFF3B30, // Red (Product(RED))
      0xff00FF00, // Green
      0xffFFC0CB, // Pink
      0xffFFFF00, // Yellow
      0xffFFA500, // Orange
      0xff800080 // Purple
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: double.maxFinite,
                      child: Hero(
                        tag: "product",
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: Image.asset(
                            product.image,
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stackTrace) =>
                                SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.width * 0.45,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 16,
                    child: IconButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.grey.shade200),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   left: 10,
                  //   bottom: 35,
                  //   child: Chip(
                  //     backgroundColor: Colors.white10,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(24)),
                  //     side: BorderSide.none,
                  //     label: Text(
                  //       "product.brand",
                  //       style: const TextStyle(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Positioned(
                  //   right: 20,
                  //   bottom: 35,
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     style: OutlinedButton.styleFrom(
                  //         backgroundColor: Colors.blueGrey.shade50,
                  //         shape: const CircleBorder(),
                  //         padding: const EdgeInsets.all(10)),
                  //     icon: Icon(
                  //       CupertinoIcons.heart,
                  //       color: Colors.amber.shade800,
                  //       size: 30,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    24,
                  ),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blueGrey.shade50,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10)),
                          icon: Icon(
                            CupertinoIcons.heart,
                            color: Colors.amber.shade800,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: appleColors.length,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              border: index == 0
                                  ? Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 2)
                                  : null,
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Color(appleColors[index]),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: double.parse(product.rating).abs(),
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 30,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          const SizedBox(width: 10),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                product.rating,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "(${product.reviews} Reviews)",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SeeMore(
                      productDescription: product.description,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding:
            const EdgeInsets.only(left: 24, top: 12, right: 24, bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$ ${product.price}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.55,
              child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<HomeBloc>()
                        .add(HomeAddToCartEvent(product, context));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${product.name} added to the cart"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: !context
                          .read<CartBloc>()
                          .cartItems
                          .any((element) => element.id == product.id)
                      ? const Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white),
                        )
                      : const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 30,
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
