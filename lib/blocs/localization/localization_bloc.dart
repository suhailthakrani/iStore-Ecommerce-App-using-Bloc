import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/localizations/localization_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'localization_event.dart';


part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final localizationController = Get.find<LocalizationController>();
  final GetStorage box;
  LocalizationBloc(this.box) : super(LocalizationInitialState()) {
    localizationController.currentLanguage = box.read('lang') ?? 'en';
    localizationController.directionRTL = box.read('isRtl') ?? true;
    on<LocalizationInitialEvent>(mapAppInitialEvent);
    on<LocalizationChangedEvent>(mapAppLocalizationChangedEvent);
    on<LocalizationSetDirectionEvent>(mapAppSetDirectionChangedEvent);
    on<LocalizationSetLanguageEvent>(mapAppSetLanguageChangedEvent);
    

  }

  FutureOr<void> mapAppInitialEvent(LocalizationInitialEvent event, Emitter<LocalizationState> emit) {
    try {
   
      emit(LocalizationLoadedState(locale: Locale(localizationController.currentLanguage), isRtl: localizationController.directionRTL));
    } catch (error) {
      emit(LocalizationErrorState(error: error.toString()));
    }
  }
  FutureOr<void> mapAppLocalizationChangedEvent(LocalizationChangedEvent event, Emitter<LocalizationState> emit) {
    try {
 
      emit(LocalizationLoadedState(locale: Locale(localizationController.currentLanguage), isRtl: localizationController.directionRTL));
    } catch (error) {
      emit(LocalizationErrorState(error: error.toString()));
    }
  }

  FutureOr<void> mapAppSetLanguageChangedEvent(LocalizationSetLanguageEvent event, Emitter<LocalizationState> emit) {
    try {
      emit(LocalizationLoadingState());
      localizationController.currentLanguage = event.languageCode;
      localizationController.box.write('lang', event.languageCode);
      emit(LocalizationUpdateState(languageCode: localizationController.currentLanguage, isRtl: localizationController.directionRTL));
    } catch (error) {
      emit(LocalizationErrorState(error: error.toString()));
    }
  
  }
   FutureOr<void> mapAppSetDirectionChangedEvent(LocalizationSetDirectionEvent event, Emitter<LocalizationState> emit) {
    try {
      emit(LocalizationLoadingState());
      localizationController.directionRTL = event.isRtl;
      localizationController.box.write('isRtl', event.isRtl);
      emit(LocalizationUpdateState(languageCode:localizationController.currentLanguage, isRtl: localizationController.directionRTL));
    } catch (error) {
      emit(LocalizationErrorState(error: error.toString()));
    }
  
  }
}
