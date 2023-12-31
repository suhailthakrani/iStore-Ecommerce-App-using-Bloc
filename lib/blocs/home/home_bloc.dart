import 'dart:async';
import 'dart:convert';

import 'package:bloc_cart_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../commons/models/product.dart';
import '../../commons/models/product_categories.dart';
import '../../repositories/product_repo/products_repository.dart';
import '../cart/cart_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductsRepository productsRepository;
  ProductsModel products = ProductsModel(products: []);
  List<Product> trendings = [];
  List<Product> recommended = [];
  List<Product> sepcialDiccountOffers = [];
  List<Product> lootLo = [];
  List<Product> flashSale = [];
  List<Product> superDeals = [];

  HomeBloc({required this.productsRepository}) : super(HomeInitialState()) {
    on<HomeInitialEvent>(mapHomeInitialEvent);
    on<HomeAddToCartEvent>(mapHomeAddToCartEvent);
    on<HomeAddToWishlistEvent>(mapHomeAddToWishlistEvent);
    on<HomeNavigateToCartEvent>(mapHomeNavigateToCartEvent);
    on<HomeLogoutButtonPressedEvent>(mapHomeLogoutButtonEventtoState);
  }

  FutureOr<void> mapHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());
      products = await productsRepository.loadProductaFromJson();


      print(products.products.map((e) => e.category));
      emit(HomeLoadedState(products: products,trendings: trendings, recommended: recommended, sepcialDiccountOffers: sepcialDiccountOffers, lootLo: lootLo, flashSale: flashSale, superDeals: superDeals));
    } on Exception catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> mapHomeAddToCartEvent(
      HomeAddToCartEvent event, Emitter<HomeState> emit) {
    try {
      final cartBloc = BlocProvider.of<CartBloc>(event.context);
      cartBloc.add(CartAddItemEvent(product: event.product));
      emit(HomeInitialState());
    } on Exception catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
  FutureOr<void> mapHomeAddToWishlistEvent(
    HomeAddToWishlistEvent event, Emitter<HomeState> emit) {
    try {
      final wishlistBloc = BlocProvider.of<WishlistBloc>(event.context);
      wishlistBloc.add(WishlistAddItemEvent(event.product));
      emit(HomeInitialState());
     
    } on Exception catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> mapHomeNavigateToCartEvent(
      HomeNavigateToCartEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartState());
  }

  //
  // Products
  //
  Future<List<Product>> loadJsonFile() async {
    final jsonString = await rootBundle.loadString('assets/json/product.json');
    final data = json.decode(jsonString);
    final List<Product> productList = List<Product>.from(
    data['products'].map((product) => Product.fromJson(product)),
    );
    return productList;
    
  }

  FutureOr<void> mapHomeLogoutButtonEventtoState(HomeLogoutButtonPressedEvent event, Emitter<HomeState> emit) {
    emit(HomeLogoutState());
  }
}
