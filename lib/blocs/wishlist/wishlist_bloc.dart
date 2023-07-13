import 'dart:async';

import 'package:bloc_cart_app/blocs/cart/cart_bloc.dart';
import 'package:bloc_cart_app/commons/models/product_categories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../commons/models/product.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<CategoryProduct> wishlistItems = [];
  WishlistBloc() : super( WishlistInitialState()) {
    on<WishlistInitialEvent>(mapWishlistInitialEventToState);
    on<WishlistAddItemEvent>(mapWishlistAddItemEventToState);
    on<WishlistRemoveItemEvent>(mapWishlistRemoveItemEventToState);
    on<WishlistAddItemToCartEvent>(mapWishlistAddItemToCartEventToState);
  }

  FutureOr<void> mapWishlistAddItemEventToState(
      WishlistAddItemEvent event, Emitter<WishlistState> emit) {
    if (!wishlistItems.contains(event.product)) {
      wishlistItems.add(event.product);
      emit(WishlistLoadedState(wishlistItems: wishlistItems));
    }else{
      emit(const WishlistAlreadyPresentState(message: "Item is already present in your wishlist!"));
    }
  }

  FutureOr<void> mapWishlistRemoveItemEventToState(
      WishlistRemoveItemEvent event, Emitter<WishlistState> emit) {
      wishlistItems.remove(event.product);
      emit(WishlistInitialState());
  }

  FutureOr<void> mapWishlistInitialEventToState(WishlistInitialEvent event, Emitter<WishlistState> emit) {
  emit(WishlistLoadedState(wishlistItems: wishlistItems));
  }

  FutureOr<void> mapWishlistAddItemToCartEventToState(WishlistAddItemToCartEvent event, Emitter<WishlistState> emit) {
    try {
      final cartBloc = BlocProvider.of<CartBloc>(event.context);
      cartBloc.add(CartAddItemEvent(product: event.product));
      emit(WishlistInitialState());
    } catch (error) {
      emit(WishlistErrorState(error: error.toString()));
    }
  }
}
