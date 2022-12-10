part of leaf_data;

typedef BlocObserverOnChangeCallback = void Function(
  BlocBase,
  Change,
);
typedef BlocObserverOnErrorCallback = void Function(
  BlocBase,
  Object,
  StackTrace,
);

class LFBlocObserver extends BlocObserver {
  BlocObserverOnChangeCallback? onChangeCallback;
  BlocObserverOnErrorCallback? onErrorCallback;

  LFBlocObserver();

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
