part of '../../leaf_store.dart';

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
