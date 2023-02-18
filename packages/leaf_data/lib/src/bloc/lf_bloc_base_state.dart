part of leaf_data;

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
