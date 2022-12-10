part of leaf_data;

typedef BlocScreenSuccessListener<S> = void Function(
  BuildContext context,
  S state,
);

typedef BlocScreenErrorListener<S> = void Function(
  BuildContext context,
  String? errorMessage,
  dynamic exception,
);

class BlocScreenConsumer<B extends BlocBase<S>, S> extends StatelessWidget {
  final BlocWidgetBuilder<S> builder;
  final BlocScreenSuccessListener<S> successListener;
  final BlocScreenErrorListener<S>? errorListener;

  const BlocScreenConsumer({
    Key? key,
    required this.builder,
    required this.successListener,
    required this.errorListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      builder: builder,
      listener: (context, state) {
        if (state is BaseState) {
          final success = state.success ?? false;
          final errorMessage = state.errorMessage;
          final exception = state.exception;

          if (!success && (errorMessage != null || exception != null)) {
            errorListener?.call(context, errorMessage, exception);
          }
        }
        successListener.call(context, state);
      },
    );
  }
}

class BaseState extends Equatable {
  final bool? success;
  final String? errorMessage;
  final dynamic exception;

  const BaseState({
    this.success,
    this.errorMessage,
    this.exception,
  });

  @override
  List<Object?> get props => [
        success,
        errorMessage,
        exception,
      ];

  BaseState copyWith({
    bool? Function()? success,
    String? Function()? errorMessage,
    dynamic Function()? exception,
  }) {
    return BaseState(
      success: success != null ? success() : this.success,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      exception: exception != null ? exception() : this.exception,
    );
  }
}
