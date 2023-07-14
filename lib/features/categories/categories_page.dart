import 'package:bloc_cart_app/commons/constants/constants.dart';
import 'package:bloc_cart_app/commons/models/categories.dart';
import 'package:bloc_cart_app/features/categories/components/category/signle_category_products_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../localizations/localization_keys.dart';
import '../cart/cart_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(const HomeInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
      if (state is HomeInitialState) {
        context.read<HomeBloc>().add(const HomeInitialEvent());
      }
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
    }, builder: (context, state) {
      switch (state.runtimeType) {
        case HomeLoadingState:
        return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
        case HomeLoadedState:
          final loadedState = state as HomeLoadedState;
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title:  Text(
                Tkeys.findFavoriteProduct.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ).tr(),
            ),
            body: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(
                      Categories.categories.length,
                      (index) => GestureDetector(
                        onTap: () async {
                          print(Categories.categories[index].name);
                          await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SingleCategoryProductPage(
                              category: loadedState.products
                                  .getProductsByCategory(
                                      Categories.categories[index].name),
                            ),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(3, 3),
                                )
                              ]),padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image(
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    height: MediaQuery.of(context).size.width *
                                        0.27,
                                    image: AssetImage(
                                      Categories.categories[index].image,
                                    ), // Replace with your image path
                                  ),
                                ),
                              ),
                              Text(
                                AppConstants().categoryValues[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor),
                              ).tr()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        case HomeErrorState:
          return const Scaffold(
            body: Center(
              child: Text("Ups! Something went wrong!"),
            ),
          );

        default:
          return const Scaffold(
            body: Center(
              child: Text("No Categories Products!"),
            ),
          );
      }
    });
  }
}
