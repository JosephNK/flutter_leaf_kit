import 'package:dart_object_extension/dart_object_extension.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit_store.dart';

part 'person.g.dart';

@CopyWith()
class Person extends UIModel {
  final String name;
  final int? age;

  const Person({
    required super.payload,
    required this.name,
    this.age,
  });

  @override
  List<Object?> get props => [
        payload,
        name,
        age,
      ];

  @override
  String? getPayload<String>() {
    return super.payload as String?;
  }
}
