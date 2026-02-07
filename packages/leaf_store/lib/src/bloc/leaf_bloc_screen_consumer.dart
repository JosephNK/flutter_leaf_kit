part of '../../leaf_store.dart';

typedef BlocScreenSuccessListener<S> = void Function(
  BuildContext context,
  S state,
);

typedef BlocScreenErrorListener<S> = void Function(
  BuildContext context,
  dynamic exception,
);

class BlocScreenConsumer<B extends BlocBase<S>, S> extends StatelessWidget {
  final BlocWidgetBuilder<S> builder;
  final BlocScreenSuccessListener<S> successListener;
  final BlocScreenErrorListener<S>? errorListener;

  const BlocScreenConsumer({
    super.key,
    required this.builder,
    required this.successListener,
    required this.errorListener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      builder: builder,
      listener: (context, state) {
        if (state is BlocBaseState) {
          final exception = state.exception;
          if (exception != null) {
            errorListener?.call(context, exception);
          }
        }
        successListener.call(context, state);
      },
    );
  }
}
