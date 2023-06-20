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

class HomeInitialState extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeLoadedState extends HomeState {
  final List<Product> products;
  const HomeLoadedState({
    required this.products,
  });
}
class HomeErrorState extends HomeState {
final String errorMessage;
  const HomeErrorState({
    required this.errorMessage,
  });
}
// 
class HomeNavigateToCartState extends HomeActionState {

}

