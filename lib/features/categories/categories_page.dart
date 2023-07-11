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
              title: const Text('Product Search'),
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
                  onPressed: () {
                   
                  },
                  icon: const Icon(CupertinoIcons.slider_horizontal_3),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  leading: Image.asset(
                    product.image,
                    width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.brand),
                  onTap: () {
                    // Handle product tap
                  },
                );
              },
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
