import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    // print('onEvent: $event');
    super.onEvent(bloc, event);
  }
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
    // Perform any actions based on the state change
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // print('onTransition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError: $error');
    super.onError(bloc, error, stackTrace);
  }
}
