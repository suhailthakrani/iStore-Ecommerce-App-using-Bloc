import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc/main_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      body: BlocBuilder<MainBloc, MainState>(builder:(context, state) {
        return mainBloc.pages[mainBloc.state.selectedIndex];
      },),
      
      bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey,
            currentIndex: mainBloc.state.selectedIndex,
            onTap:(index) {
              mainBloc.add(MainTabChangeEvent(index));
            },
            items: mainBloc.tabs,
          );
        },
      ),
    );
  }
}
