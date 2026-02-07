part of '../index.dart';

class BlocBaseState extends Equatable {
  final Object? exception;

  const BlocBaseState({required this.exception});

  @override
  List<Object?> get props => [exception];
}
