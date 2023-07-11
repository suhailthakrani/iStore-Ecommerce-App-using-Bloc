// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:bloc_cart_app/localizations/localization_service.dart';

import 'localization_event.dart';

part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {

  String currentLanguage = '';
  LocalizationService localizationService;
  bool directionRTL = true;

  final GetStorage box;

  LocalizationBloc({
    required this.localizationService,
    required this.box,
  }) : super(LocalizationInitialState()) {

    currentLanguage = box.read('lang') ?? 'en';
    directionRTL = box.read('isRtl') ?? false;
    
    on<LocalizationInitialEvent>(mapLocalizationInitialEvent);
    on<LocalizationChangedEvent>(mapLocalizationChangedEvent);  

  }

  Future<FutureOr<void>> mapLocalizationInitialEvent(LocalizationInitialEvent event, Emitter<LocalizationState> emit) async {
    try {
      
      emit(LocalizationLoadedState(locale: Locale(localizationService.locale.languageCode), isRtl: directionRTL));
    } catch (error) {
      emit(LocalizationErrorState(error: error.toString()));
    }
  }

  Future<FutureOr<void>> mapLocalizationChangedEvent(LocalizationChangedEvent event, Emitter<LocalizationState> emit) async {
    try {
      await box.write('lang', event.languageCode);
      await box.write('isRtl', event.isLTR);
      currentLanguage = event.languageCode;
      directionRTL = event.isLTR;
      await localizationService.changeLocale(event.languageCode);
      await localizationService.load();
      emit(LocalizationLoadedState(locale: Locale(event.languageCode), isRtl: event.isLTR, ));
    } catch (error) {
      emit(LocalizationErrorState(error: error.toString()));
    }
  }

}
