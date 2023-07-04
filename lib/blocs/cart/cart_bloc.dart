// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../data/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Product> cartItems = [];
  double totalPrice = 0.0;
  int totalItems = 0;
  CartBloc() : super(CartInitialState()) {
    on<CartInitialEvent>(mapCartInitialEvent);
    on<CartLoadedEvent>(mapCartLoadedEvent);
    on<CartAddItemEvent>(mapCartAddItemEvent);
    on<CartRemoveItemEvent>(mapCartRemoveItemEvent);
  }

  FutureOr<void> mapCartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    try {
      emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(
        CartErrorState(
          error: error.toString(),
        ),
      );
    }
  }

  FutureOr<void> mapCartLoadedEvent(
      CartLoadedEvent event, Emitter<CartState> emit) {
    try {
      emit(CartLoadedState(cartItems: cartItems));
    } catch (error) {
      emit(
        CartErrorState(
          error: error.toString(),
        ),
      );
    }
  }

  FutureOr<void> mapCartAddItemEvent(
      CartAddItemEvent event, Emitter<CartState> emit) {
    try {
      final index =
          cartItems.indexWhere((element) => element.id == event.product.id);
      if (index >= 0) {
        final updatedItem =
            cartItems[index].copyWith(quantity: cartItems[index].quantity + 1);
        cartItems[index] = updatedItem;
        totalPrice = totalPrice + double.parse(event.product.price);
        totalItems+=1;
      } else {
        cartItems. add(event.product);
        totalPrice = totalPrice + double.parse(event.product.price);
        totalItems+=1;

      }
     emit(CartInitialState());
      // emit(CartLoadedState(cartItems: cartItems));
      //  emit(CartItemQuantityChangedState(cartItem: cartItems[index]));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }

  double get totalCartItems {
    num items = 0;
    for (var item in cartItems) {
      items+= item.quantity;
    }
    return 0.0;
  }

  FutureOr<void> mapCartRemoveItemEvent(
      CartRemoveItemEvent event, Emitter<CartState> emit) async {
    try {
      final index =
          cartItems.indexWhere((element) => element.id == event.product.id);
      if (index > -1) {
        if (cartItems[index].quantity > 1) {
          totalPrice = totalPrice - double.parse(event.product.price);
          totalItems-=1;
          final updatedItem = cartItems[index]
              .copyWith(quantity: cartItems[index].quantity - 1);
          cartItems[index] = updatedItem;
        } else {
          totalPrice = totalPrice - double.parse(event.product.price);
          cartItems.remove(event.product);
          totalItems-=1;
        }
      }
      
      
      emit(CartInitialState());
    //  emit(CartItemQuantityChangedState(cartItem: cartItems[index]));
    } catch (error) {
      emit(CartErrorState(error: error.toString()));
    }
  }



  //
  
}
