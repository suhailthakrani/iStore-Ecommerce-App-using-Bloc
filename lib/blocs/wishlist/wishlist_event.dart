// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}
class WishlistInitialEvent extends WishlistEvent {

  @override
  List<Object> get props => [];
}
class WishlistAddItemToCartEvent extends WishlistEvent {
  final CategoryProduct product;
  final BuildContext context;
  const WishlistAddItemToCartEvent(
    this.product,
    this.context,
  );

  @override
  List<Object> get props => [product];
}
class WishlistAddItemEvent extends WishlistEvent {
  final CategoryProduct product;
  const WishlistAddItemEvent(
    this.product,
  );

  @override
  List<Object> get props => [product];
}
class WishlistRemoveItemEvent extends WishlistEvent {
  final CategoryProduct product;
  const WishlistRemoveItemEvent(
    this.product,
  );

  @override
  List<Object> get props => [product];
}
