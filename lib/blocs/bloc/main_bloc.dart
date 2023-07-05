import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/cart_page.dart';
import '../../features/categories/categories_page.dart';
import '../../features/home/home_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/wishlist/wishlist_page.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  int selectedIndex = 0;
  final pages = const[
    HomePage(),
    CategoriesPage(),
    CartPage(),
    WishlistPage(),
    ProfilePage(),
  ];

  final tabs = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
    MainBloc() : super(MainState(0)) {
    on<MainTabChangeEvent>((event, emit) {
      emit(MainState(event.selectedIndex));
    });
  }
  
}
