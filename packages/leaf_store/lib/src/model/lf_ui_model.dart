part of '../../leaf_store.dart';

abstract class UIModelInterface {
  T? getPayload<T>();
}

abstract class UIModel extends Equatable implements UIModelInterface {
  final Object? payload;

  const UIModel({
    required this.payload,
  });

  @override
  List<Object?> get props => [
        payload,
      ];
}
