part of '../index.dart';

typedef BlocScreenSuccessListener<S> =
    void Function(BuildContext context, S state);

typedef BlocScreenErrorListener<S> =
    void Function(BuildContext context, dynamic exception);

class BlocScreenConsumer<B extends BlocBase<S>, S> extends StatelessWidget {
  final BlocWidgetBuilder<S> builder;
  final BlocScreenSuccessListener<S> successListener;
  final BlocScreenErrorListener<S>? errorListener;
  final bool Function(S state)? errorWhen;

  const BlocScreenConsumer({
    super.key,
    required this.builder,
    required this.successListener,
    this.errorListener,
    this.errorWhen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      builder: builder,
      listener: (context, state) {
        // 기존 BlocBaseState 방식 (하위 호환)
        if (state is BlocBaseState) {
          final exception = state.exception;
          if (exception != null) {
            errorListener?.call(context, exception);
            return;
          }
        }
        // 커스텀 errorWhen 방식
        if (errorWhen != null && errorWhen!(state)) {
          errorListener?.call(context, state);
          return;
        }
        successListener.call(context, state);
      },
    );
  }
}
