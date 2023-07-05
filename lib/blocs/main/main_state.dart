// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

class MainState extends Equatable {
  int selectedIndex;
  MainState(
    this.selectedIndex,
  );
  
  @override
  List<Object> get props => [selectedIndex];
}

