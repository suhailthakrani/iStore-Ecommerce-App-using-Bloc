// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object?> get props => [];
}

class LocalizationInitialEvent extends LocalizationEvent {}

class LocalizationChangedEvent extends LocalizationEvent {
  final String languageCode;
  final bool isLTR;

  const LocalizationChangedEvent({
    required this.languageCode,
    required this.isLTR,
  });

  @override
  List<Object?> get props => [languageCode, isLTR];
}