import 'dart:convert';

import 'package:bloc_cart_app/commons/models/product_categories.dart';
import 'package:flutter/services.dart';

import '../commons/models/product.dart';

class ProductsRepository {
  Future<ProductsModel> loadProductaFromJson() async {

    final jsonString = await rootBundle.loadString('assets/json/all_products.json');
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    ProductsModel productsModel = ProductsModel.fromJson(jsonMap);

    return productsModel;

  }
  Future<List<Product>> loadProduct() async {
    final jsonString = await rootBundle.loadString('assets/json/product.json');
    final data = json.decode(jsonString);
    final List<Product> productList = List<Product>.from(
    data['products'].map((product) => Product.fromJson(product)),
    );
    return productList;
    
  }
}