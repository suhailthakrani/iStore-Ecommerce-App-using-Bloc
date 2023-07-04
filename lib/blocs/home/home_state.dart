// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}
abstract class HomeActionState extends HomeState {
  const HomeActionState();
  
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {
    @override
  List<Object> get props => [];
}
class HomeLoadingState extends HomeState {
    @override
  List<Object> get props => [];
}
class HomeLoadedState extends HomeState {
  final List<Product> products;
  const HomeLoadedState({
    required this.products,
  });
    @override
  List<Object> get props => [products];
}
class HomeErrorState extends HomeState {
final String errorMessage;
  const HomeErrorState({
    required this.errorMessage
  });
    @override
  List<Object> get props => [errorMessage];
}
// 
class HomeNavigateToCartState extends HomeActionState {
    @override
  List<Object> get props => [];

}
class HomeLogoutState extends HomeActionState {
    @override
  List<Object> get props => [];

}
class HomeItemAddedToCartState extends HomeActionState {
  final Product product;
  const HomeItemAddedToCartState({
    required this.product,
  });
    @override
  List<Object> get props => [product];
}

