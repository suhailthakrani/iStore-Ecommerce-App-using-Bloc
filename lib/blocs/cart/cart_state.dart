// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {
    @override
  List<Object> get props => [];
}
class CartLoadingState extends CartState {
    @override
  List<Object> get props => [];
}
class CartLoadedState extends CartState {
  final List<CategoryProduct> cartItems;
  const CartLoadedState({
    required this.cartItems,
  });
    @override
  List<Object> get props => [cartItems];
}
class CartItemQuantityChangedState extends CartState {
  final CategoryProduct cartItem;
  const CartItemQuantityChangedState({
    required this.cartItem,
  });
    @override
  List<Object> get props => [cartItem];
}
class CartErrorState extends CartState {
  final String error;
  const CartErrorState({
    required this.error,
  });
    @override
  List<Object> get props => [error];

}

