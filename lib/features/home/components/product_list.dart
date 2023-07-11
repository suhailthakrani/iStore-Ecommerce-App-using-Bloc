// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'package:bloc_cart_app/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/cart/cart_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/wishlist/wishlist_bloc.dart';
import '../product/product_details_page.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
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
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        fit: BoxFit.contain,
                        image: AssetImage(
                          product.image,
                        ),
                        errorBuilder: (context, error, stackTrace) => SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
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
                        style:  TextStyle(
                          color: Colors.blue.shade900,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      HomeAddToWishlistEvent(product, context));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${product.name} added to the wishlist"),
                                    ),
                                  );
                                },
                                style: IconButton.styleFrom(
                                  padding: const EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                icon: context
                                        .read<WishlistBloc>()
                                        .wishlistItems
                                        .contains(product)
                                    ? Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Colors.yellow.shade700,
                                      )
                                    : const Icon(CupertinoIcons.heart),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                        HomeAddToCartEvent(product, context));

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "${product.name} added to the cart"),
                                      ),
                                    );
                                  },
                                  style: IconButton.styleFrom(
                                    padding: const EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  icon: context
                                          .read<CartBloc>()
                                          .cartItems
                                          .contains(product)
                                      ? const Icon(Icons.done)
                                      : const Icon(CupertinoIcons.cart))
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
    );
  }
}
