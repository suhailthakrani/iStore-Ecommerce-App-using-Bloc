import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(mapHomeInitialEvent);
    on<HomeAddToCartEvent>(mapHomeAddToCartEvent);
    on<HomeNavigateToCartEvent>(mapHomeNavigateToCartEvent);
  }

  Future<FutureOr<void>> mapHomeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitialState());
    await Future.delayed(const Duration(seconds: 1),);
     List<Product> products = [
      const Product(id: 1, name: "Product 1", price: 10.0),
      const Product(id: 2, name: "Product 2", price: 20.0),
      const Product(id: 3, name: "Product 3", price: 30.0),
      const Product(id: 4, name: "Product 4", price: 10.0),
      const Product(id: 5, name: "Product 5", price: 20.0),
      const Product(id: 6, name: "Product 6", price: 30.0),
    ];

    emit(HomeLoadedState(products: products));
  }

  FutureOr<void> mapHomeAddToCartEvent(HomeAddToCartEvent event, Emitter<HomeState> emit) {

  }

  FutureOr<void> mapHomeNavigateToCartEvent(HomeNavigateToCartEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartState());
  }
}
