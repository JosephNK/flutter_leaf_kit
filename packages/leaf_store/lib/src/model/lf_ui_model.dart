part of '../../leaf_store.dart';

class UIModel extends Equatable {
  final Object? payload;

  const UIModel({
    required this.payload,
  });

  @override
  List<Object?> get props => [
        payload,
      ];

  T? getPayload<T>() {
    if (payload is T) {
      return payload as T;
    }
    return null;
  }
}
