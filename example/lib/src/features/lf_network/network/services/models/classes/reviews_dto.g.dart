// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReviewsDTO> _$reviewsDTOSerializer = new _$ReviewsDTOSerializer();

class _$ReviewsDTOSerializer implements StructuredSerializer<ReviewsDTO> {
  @override
  final Iterable<Type> types = const [ReviewsDTO, _$ReviewsDTO];
  @override
  final String wireName = 'ReviewsDTO';

  @override
  Iterable<Object?> serialize(Serializers serializers, ReviewsDTO object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.like;
    if (value != null) {
      result
        ..add('like')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.created;
    if (value != null) {
      result
        ..add('created')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.contents;
    if (value != null) {
      result
        ..add('contents')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ReviewsDTO deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewsDTOBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'like':
          result.like = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'contents':
          result.contents = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewsDTO extends ReviewsDTO {
  @override
  final int? like;
  @override
  final int? created;
  @override
  final String? contents;

  factory _$ReviewsDTO([void Function(ReviewsDTOBuilder)? updates]) =>
      (new ReviewsDTOBuilder()..update(updates))._build();

  _$ReviewsDTO._({this.like, this.created, this.contents}) : super._();

  @override
  ReviewsDTO rebuild(void Function(ReviewsDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewsDTOBuilder toBuilder() => new ReviewsDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewsDTO &&
        like == other.like &&
        created == other.created &&
        contents == other.contents;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, like.hashCode);
    _$hash = $jc(_$hash, created.hashCode);
    _$hash = $jc(_$hash, contents.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ReviewsDTO')
          ..add('like', like)
          ..add('created', created)
          ..add('contents', contents))
        .toString();
  }
}

class ReviewsDTOBuilder implements Builder<ReviewsDTO, ReviewsDTOBuilder> {
  _$ReviewsDTO? _$v;

  int? _like;
  int? get like => _$this._like;
  set like(int? like) => _$this._like = like;

  int? _created;
  int? get created => _$this._created;
  set created(int? created) => _$this._created = created;

  String? _contents;
  String? get contents => _$this._contents;
  set contents(String? contents) => _$this._contents = contents;

  ReviewsDTOBuilder();

  ReviewsDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _like = $v.like;
      _created = $v.created;
      _contents = $v.contents;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewsDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewsDTO;
  }

  @override
  void update(void Function(ReviewsDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ReviewsDTO build() => _build();

  _$ReviewsDTO _build() {
    final _$result = _$v ??
        new _$ReviewsDTO._(like: like, created: created, contents: contents);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
