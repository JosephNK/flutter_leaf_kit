import 'package:equatable/equatable.dart';

/// UIModelV1

abstract class UIModelInterface {
  T? getPayload<T>();
}

abstract class UIModel extends Equatable implements UIModelInterface {
  final Object? payload;

  const UIModel({required this.payload});

  @override
  List<Object?> get props => [payload];
}

/// UIModelV2

abstract class UIModelV2Interface {
  Object? getPayload();
}

abstract class UIModelV2<P> extends Equatable implements UIModelV2Interface {
  final P? _payload;

  const UIModelV2({P? payload}) : _payload = payload;

  @override
  List<Object?> get props => [_payload];

  P? get payload {
    // throw Exception(
    //     'You cannot access the Payload property directly. Please use the getPayload function.');
    return _payload;
  }

  @override
  P? getPayload() => _payload;
}
