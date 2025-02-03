import 'package:dart_object_extension/dart_object_extension.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_store.dart';

part 'person.g.dart';

@CopyWith()
class Person extends UIModel {
  final String name;
  final int? age;

  const Person({
    super.payload,
    required this.name,
    this.age,
  });

  @override
  List<Object?> get props => [
        super.props,
        name,
        age,
      ];

  @override
  String? getPayload<String>() {
    return super.payload as String?;
  }
}

@CopyWith()
class PersonV2 extends UIModelV2<String> {
  final String name;
  final int? age;

  const PersonV2({
    super.payload,
    required this.name,
    this.age,
  });

  @override
  List<Object?> get props => [
        super.props, // important
        name,
        age,
      ];
}
