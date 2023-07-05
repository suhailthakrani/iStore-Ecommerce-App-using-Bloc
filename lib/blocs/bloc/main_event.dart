// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}
class MainTabChangeEvent extends MainEvent {
  final int selectedIndex;
  const MainTabChangeEvent(
    this.selectedIndex,
  );

  @override
  List<Object> get props => [selectedIndex];
}
