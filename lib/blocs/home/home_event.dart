// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}
class HomeInitialEvent extends HomeEvent {
  const HomeInitialEvent();

  @override
  List<Object> get props => [];
}
class HomeAddToCartEvent extends HomeEvent {
  final Product product;
  final BuildContext context;
  const HomeAddToCartEvent(
    this.product,
    this.context,
  );

  @override
  List<Object> get props => [product,context];
}
class HomeAddToWishlistEvent extends HomeEvent {
  final Product product;
  final BuildContext context;
  const HomeAddToWishlistEvent(
    this.product,
    this.context,
  );

  @override
  List<Object> get props => [product, context];
}
class HomeNavigateToCartEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeMoreMenuButtonPressedEvent extends HomeEvent {
  
    @override
  List<Object> get props => [];
}
class HomeLogoutButtonPressedEvent extends HomeEvent {
  
    @override
  List<Object> get props => [];
}
 

