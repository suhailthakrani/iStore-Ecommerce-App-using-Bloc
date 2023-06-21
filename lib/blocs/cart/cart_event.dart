// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}
class CartInitialEvent extends CartEvent {
  
  @override
  List<Object> get props => [];
}
class CartLoadedEvent extends CartEvent {
  
  @override
  List<Object> get props => [];
}
class CartAddItemEvent extends CartEvent {
  final Product product;
  const CartAddItemEvent({
    required this.product,
  });
  
  @override
  List<Object> get props => [product];
}
class CartRemoveItemEvent extends CartEvent {
    final Product product;
  const CartRemoveItemEvent({
    required this.product,
  });
  
  @override
  List<Object> get props => [product];
}
