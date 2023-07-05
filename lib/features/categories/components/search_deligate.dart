import 'package:flutter/material.dart';

import '../../../data/product_model.dart';

class ProductSearchDelegate extends SearchDelegate<Product> {
  final List<Product> products;

  ProductSearchDelegate({required this.products});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, Product.empty());
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(product.brand),
          onTap: () {
            close(context, product);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
           leading: Image.asset(product.image),
          title: Text(product.name),
          subtitle: Text(product.brand),
          onTap: () {
            query = product.name;
            close(context, product);
          },
        );
      },
    );
  }
}
