// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitialState extends CartState {}
class CartLoadingState extends CartState {}
class CartLoadedState extends CartState {
  final List<Product> products;
  const CartLoadedState({
    required this.products,
  });
}
class CartErrorState extends CartState {

}

