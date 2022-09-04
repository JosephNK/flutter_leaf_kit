import 'package:flutter_bloc/flutter_bloc.dart';

typedef BlocObserverOnChangeCallback = void Function(BlocBase, Change);
typedef BlocObserverOnErrorCallback = void Function(
    BlocBase, Object, StackTrace);

class LeafBlocObserver extends BlocObserver {
  BlocObserverOnChangeCallback? onChangeCallback;
  BlocObserverOnErrorCallback? onErrorCallback;

  LeafBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    onChangeCallback?.call(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    onErrorCallback?.call(bloc, error, stackTrace);
  }
}
