part of leaf_bloc;

class DataModel extends Equatable {
  final Object? data;

  const DataModel({
    required this.data,
  });

  @override
  List<Object?> get props => [
        data,
      ];
}
