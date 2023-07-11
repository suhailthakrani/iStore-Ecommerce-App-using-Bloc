// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'localization_bloc.dart';

abstract class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object> get props => [];
}

class LocalizationInitialState extends LocalizationState {
  @override
  List<Object> get props => [];
}

class LocalizationLoadedState extends LocalizationState {
  final Locale locale;
  final bool isRtl;
  const LocalizationLoadedState({
    required this.locale,
    required this.isRtl,
  });
  @override
  List<Object> get props => [locale, isRtl];
}

class LocalizationErrorState extends LocalizationState {
  final String error;
  const LocalizationErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [];
}
