import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/product_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<Product> wishlistItems = [];
  WishlistBloc() : super( WishlistInitialState()) {
    on<WishlistInitialEvent>(mapWishlistInitialEventToState);
    on<WishlistAddItemEvent>(mapWishlistAddItemEventToState);
    on<WishlistRemoveItemEvent>(mapWishlistRemoveItemEventToState);
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
}
