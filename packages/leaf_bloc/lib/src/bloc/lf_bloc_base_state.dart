part of leaf_bloc;

class BlocBaseState extends Equatable {
  final Object? exception;

  const BlocBaseState({
    required this.exception,
  });

  @override
  List<Object?> get props => [
        exception,
      ];
}
