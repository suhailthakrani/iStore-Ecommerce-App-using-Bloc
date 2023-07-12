// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();
  
  @override
  List<Object> get props => [];
}

class WishlistInitialState extends WishlistState {

  @override
  List<Object> get props => [];
}
class WishlistLoadedState extends WishlistState {
  final List<CategoryProduct> wishlistItems;
  const WishlistLoadedState({
    required this.wishlistItems,
  });
  @override
  List<Object> get props => [wishlistItems];
}
class WishlistErrorState extends WishlistState {
  final String error;
  const WishlistErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
class WishlistAlreadyPresentState extends WishlistState {
  final String message;
  const WishlistAlreadyPresentState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
