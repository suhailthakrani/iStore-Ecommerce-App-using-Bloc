import 'package:bloc_cart_app/commons/models/products.dart';
import 'package:flutter/material.dart';

import '../../../commons/models/product_model.dart';

class ProductSearchDelegate extends SearchDelegate<CategoryProduct> {
  final ProductsModel products;

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
        close(context, CategoryProduct.empty());
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
     final List<CategoryProduct> filteredProducts = [];
    for (var category in products.products) {
      for (var product in category.categoryProducts) {
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          filteredProducts.add(product);
        }
      }
    }
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(product.description),
          onTap: () {
            close(context, product);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<CategoryProduct> filteredProducts = [];
    for (var category in products.products) {
      for (var product in category.categoryProducts) {
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          filteredProducts.add(product);
        }
      }
    }
    

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          leading: Image.asset(product.image),
          title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text(product.description, maxLines: 1, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),),
          onTap: () {
            query = product.name;
            close(context, product);
          },
        );
      },
    );
  }
}
