import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
