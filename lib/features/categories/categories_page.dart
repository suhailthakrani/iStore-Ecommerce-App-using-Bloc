import 'package:bloc_cart_app/commons/models/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home_bloc.dart';
import 'components/search_deligate.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Product Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: ProductSearchDelegate(products: state.products),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.slider_horizontal_3),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(30),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(
                      Categories.categories.length,
                      (index) => Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(3, 3),
                              )
                            ]),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height:
                                    MediaQuery.of(context).size.width * 0.28,
                                image: AssetImage(
                                  Categories.categories[index].image,
                                ), // Replace with your image path
                              ),
                            ),
                            Expanded(
                                child: Text(
                              Categories.categories[index].name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Category"),
          );
        }
      },
    );
  }
}
