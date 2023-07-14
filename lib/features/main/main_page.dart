import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/main/main_bloc.dart';
import '../../localizations/localization_keys.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return mainBloc.pages[mainBloc.state.selectedIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            unselectedItemColor: Colors.grey,
            currentIndex: mainBloc.state.selectedIndex,
            onTap: (index) {
              mainBloc.add(MainTabChangeEvent(index));
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: Tkeys.home.name.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category_outlined),
                label: Tkeys.categories.name.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Tkeys.cart.name.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite_outline_rounded),
                label: Tkeys.wishlist.name.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                label: Tkeys.profile.name.tr(),
              ),
            ],
          );
        },
      ),
    );
  }
}
