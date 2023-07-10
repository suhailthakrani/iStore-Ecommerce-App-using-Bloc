

import 'package:equatable/equatable.dart';

abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object?> get props => [];
}

class LocalizationInitialEvent extends LocalizationEvent {}

class LocalizationChangedEvent extends LocalizationEvent {}

class LocalizationSetLanguageEvent extends LocalizationEvent {
  final String languageCode;

  const LocalizationSetLanguageEvent({required this.languageCode});

  @override
  List<Object?> get props => [languageCode];
}

class LocalizationSetDirectionEvent extends LocalizationEvent {
  final bool isRtl;

  const LocalizationSetDirectionEvent(this.isRtl);

  @override
  List<Object?> get props => [isRtl];
}

class LocalizationLanguageChangedEvent extends LocalizationEvent {
  final String languageCode;

  const LocalizationLanguageChangedEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}
