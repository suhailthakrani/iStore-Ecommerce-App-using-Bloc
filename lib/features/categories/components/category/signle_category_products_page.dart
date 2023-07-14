import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/cart/cart_bloc.dart';
import '../../../../blocs/home/home_bloc.dart';
import '../../../../blocs/wishlist/wishlist_bloc.dart';
import '../../../../commons/models/product_categories.dart';
import '../../../home/product/product_details_page.dart';
import '../test_p.dart';

class SingleCategoryProductPage extends StatelessWidget {
  final Category category;
  const SingleCategoryProductPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.category,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TextP(),
              ));
            },
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4)),
            icon: const Icon(Icons.sort),
           
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: category.categoryProducts.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: category.categoryProducts.length,
              itemBuilder: (context, categoryIndex) {
                final product = category.categoryProducts[categoryIndex];
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
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  product.image,
                                ),
                                errorBuilder: (context, error, stackTrace) =>
                                    SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3,
                                ), // Replace with your image path
                              ),
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
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
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
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).primaryColor,
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
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "${product.name} added to the wishlist"),
                                            ),
                                          );
                                        },
                                        style: IconButton.styleFrom(
                                          padding: const EdgeInsets.all(8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        icon: context
                                                .read<WishlistBloc>()
                                                .wishlistItems
                                                .any((element) =>
                                                    element.id == product.id)
                                            ? Icon(
                                                CupertinoIcons.heart_fill,
                                                color: Colors.yellow.shade700,
                                              )
                                            : Icon(
                                                CupertinoIcons.heart,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                      ),
                                      IconButton(
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
                                            ),
                                          ),
                                          icon: context
                                                  .read<CartBloc>()
                                                  .cartItems
                                                  .any((element) =>
                                                      element.id == product.id)
                                              ? const Icon(Icons.done)
                                              : Icon(
                                                  CupertinoIcons.cart,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ))
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
            )
          : Center(
              child: Text(
                "No Products \nfound in this category!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 24),
              ),
            ),
    );
  }
}
